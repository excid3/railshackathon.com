class Events::Votes::MovesController < ApplicationController
  before_action :set_event
  before_action :set_vote
  before_action :voting_ended

  def up
    @vote.move_higher
    redirect_to event_votes_url(@vote.entry.event)
  end

  def down
    @vote.move_lower
    redirect_to event_votes_url(@vote.entry.event)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def set_vote
    @vote = current_user.votes.find(params[:vote_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to votes_url
  end

  def voting_ended
    redirect_to event_leaderboard_path(@event), notice: "Voting has ended for this year's Rails Hackathon entries." unless @event.voting_allowed?
  end
end
