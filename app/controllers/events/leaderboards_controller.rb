class Events::LeaderboardsController < ApplicationController
  def show
    @event = Event.find(params[:event_id])
    @entries = @event.entries.joins(:team).order(total_points: :desc)
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, notice: "Invalid Event"
  end
end
