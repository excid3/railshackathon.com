class LeaderboardsController < ApplicationController
  def show
    @entries = Entry.joins(:team).order(total_points: :desc)
  end
end
