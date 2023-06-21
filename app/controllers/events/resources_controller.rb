class Events::ResourcesController < ApplicationController
  def show
    @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, notice: "Invalid Event"
  end
end
