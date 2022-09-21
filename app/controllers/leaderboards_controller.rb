class LeaderboardsController < ApplicationController
  def show
    @entries = Entry.order(total_points: :desc)
  end
end
