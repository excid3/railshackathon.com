class DashboardController < ApplicationController
  def show
    @event = latest_event
  end
end
