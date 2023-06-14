class Events::TeamsController < ApplicationController
  
  def index
    @event = Event.find(params[:event_id])
    @teams = @event.teams
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, notice: "Invalid Event"
  end
end