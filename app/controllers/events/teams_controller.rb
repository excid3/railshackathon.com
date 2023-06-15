class Events::TeamsController < ApplicationController
  
  def index
    @event = Event.find(params[:event_id])
    @event_teams = @event.teams
    @total_developers = @event_teams.sum {|team| team.team_users.size }
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, notice: "Invalid Event"
  end
end