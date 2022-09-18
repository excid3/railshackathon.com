class LeaderboardsController < ApplicationController
  def show
    @entries = Entry.order(votes_count: :desc)
  end
end
