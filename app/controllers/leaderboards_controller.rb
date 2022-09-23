class LeaderboardsController < ApplicationController
  def show
    @entries = Entry.joins(team: :users).order(total_points: :desc)
  end
end
