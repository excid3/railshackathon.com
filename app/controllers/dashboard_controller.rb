class DashboardController < ApplicationController
  def show
    @event = Event.current || Event.previous
  end
end
