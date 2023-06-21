class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_for_admin, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.published.newest_first
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: "Event created succesfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event deleted succesfully."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, alert: "Event does not exist"
  end

  def event_params
    params.require(:event).permit(:title, :theme, :start_time, :end_time, :published)
  end
end
