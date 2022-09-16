class LeaderboardsController < ApplicationController
  def show
    @entries = Entry.order_by_total_points
  end
end
