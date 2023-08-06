module Teams
  class RepositoryInvitesController < ApplicationController
    before_action :set_team_user!

    rescue_from ActiveRecord::RecordNotFound do
      redirect_to "/", notice: "Not found; weird."
    end

    def create
      @team.add_github_collaborator(current_user.github)
      redirect_back(fallback_location: team_path(@team), notice: "You have been re-invited to the repo.")
    end

    private

    def set_team_user!
      @team_user = TeamUser.find_by!(user: current_user, team_id: params[:team_id])
      @team = @team_user.team
    end
  end
end
