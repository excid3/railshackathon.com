class Votes::MovesController < ApplicationController
  before_action :set_vote

  def up
    @vote.move_higher
    redirect_to votes_url
  end

  def down
    @vote.move_lower
    redirect_to votes_url
  end

  private

  def set_vote
    @vote = Vote.find(params[:vote_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to votes_url
  end
end
