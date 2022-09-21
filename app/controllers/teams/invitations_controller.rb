class Teams::InvitationsController < ApplicationController
  before_action :set_team
  before_action :authenticate_user!, only: [:update]
  before_action :hackathon_ended

  def show
  end

  def update
    team_user = @team.team_users.new(user: current_user)
    if team_user.save
      redirect_to team_path(@team), notice: "You've joined the team! 🎉"
    else
      redirect_to team_invitation_path(@team, @team.to_sgid(purpose: "invite")), alert: "This team is full, but you can find another team to join!"
    end
  end

  private

  def set_team
    @team = GlobalID::Locator.locate_signed(params[:id], purpose: "invite")
  end
end
