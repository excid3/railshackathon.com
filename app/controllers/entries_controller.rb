class EntriesController < ApplicationController
  before_action :authenticate_user!, only: %i[ new create edit update destroy ]
  before_action :ensure_user_has_team, except: %i[ index show ]
  before_action :set_entry, only: %i[ edit update destroy ]
  before_action :ensure_only_one_entry, only: %i[ new create ]
  before_action :hackathon_ended, except: %i[ index show ]

  def index
    @entries = Entry.order(created_at: :desc)
  end

  def show
    @entry = Entry.find(params[:id])
    @event = @entry.event
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: "Invalid Entry."
  end

  def new
    @entry = current_user.team.build_entry
  end

  def edit
    redirect_to event_entries_url(@entry.event), notice: "You are not authorized to perfom that action" unless @entry.team.team_member?(current_user)
  end

  def create
    @entry = current_user.team.build_entry(entry_params)

    respond_to do |format|
      if @entry.save
        Discord.new(@entry).post
        format.html { redirect_to entry_url(@entry), notice: "Entry was successfully created." }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to entry_url(@entry), notice: "Entry was successfully updated." }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @entry.destroy
      format.html { redirect_to event_entries_url(@entry.event), notice: "Entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :website_url, :description, :built_with, :complete, screenshots: [])
  end

  def ensure_user_has_team
    redirect_to root_url, notice: "Please create or join a team first!" unless current_user.team
  end

  def set_entry
    @entry = current_user.team.entry
    @event = @entry&.event || current_user.team.event
    redirect_to event_entries_url(@event), alert: "Please create an entry first" unless @entry
  end

  def ensure_only_one_entry
    redirect_to entry_url(current_user.team.entry), notice: "Only one entry is allowed per team" if current_user.team&.entry
  end
end
