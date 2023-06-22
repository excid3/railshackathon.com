class TeamsController < ApplicationController
  before_action :authenticate_user!, only: %i[ new create edit update destroy ]
  before_action :set_team, only: %i[ edit update destroy ]
  before_action :ensure_only_one_team, only: %i[ new create ]
  before_action :hackathon_ended, except: %i[ index show ]

  # GET /teams or /teams.json
  def index
    @teams = Team.order(created_at: :desc)
  end

  # GET /teams/1 or /teams/1.json
  def show
    @team = Team.find(params[:id])
    @event = @team.event
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: "Invalid Team."
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
    redirect_to event_teams_url(@team.event), notice: "You are not authorized to perfom that action" unless @team.team_member?(current_user)
  end

  # POST /teams or /teams.json
  def create
    @team = Team.new(team_params)
    @team.event = latest_event
    @team.team_users.build(user: current_user)

    respond_to do |format|
      if @team.save
        format.html { redirect_to team_url(@team), notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to team_url(@team), notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy

    respond_to do |format|
      format.html { redirect_to event_teams_url(@team.event), notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = current_user.team
      redirect_to teams_path, alert: "Please create a team first." unless @team
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:name, :description, :time_zone)
    end

    def ensure_only_one_team
      redirect_to team_path(current_user.team) if current_user.team
    end
end
