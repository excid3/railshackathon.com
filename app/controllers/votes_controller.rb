class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, only: %i[ create ]
  before_action :voting_ended, except: %i[ index ]

  def index
    @votes = current_user.votes.joins(:event).where(events: {id: latest_event.id}).order(:position)
  end

  def create
    vote = current_user.votes.build(entry: @entry)
    if vote.save
      redirect_to @entry, notice: "Thank you for your vote."
    else
      redirect_to @entry, alert: vote.errors[:base].first
    end
  end

  def destroy
    vote = current_user.votes.find(params[:id])
    vote.destroy
    redirect_back fallback_location: entry_path(vote.entry), notice: "Your vote has been removed successfully."
  end

  def set_entry
    @entry = latest_event.entries.find(params[:entry])
  rescue ActiveRecord::RecordNotFound
    redirect_to entries_url
  end

  def voting_ended
    redirect_to leaderboard_path, notice: "Voting has ended for this year's Rails Hackathon entries."
  end
end
