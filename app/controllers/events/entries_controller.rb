class Events::EntriesController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @event_entries = @event.entries.by_completed_status.by_title
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, notice: "Invalid Event"
  end
end
