class Events::EntriesController < ApplicationController
  
  def index
    @event = Event.find(params[:event_id])
    @entries = @event.entries
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, notice: "Invalid Event"
  end
  
end