class VotesController < ApplicationController
  before_action :authenticate_user!, only: %i[ create destroy ]
  before_action :set_entry

  def create
    vote = current_user.votes.build(entry: @entry)
    if vote.save
      redirect_to @entry, notice: "Thank you for your vote."
    else
      redirect_to @entry, notice: "Something went wrong."
    end
  end

  def destroy
    vote = current_user.votes.find_by(entry_id: @entry.id)
    vote.destroy if vote
    redirect_to @entry, notice: "Your vote has been removed successfully."
  end

  def set_entry
    @entry = Entry.find(params[:entry])
  rescue ActiveRecord::RecordNotFound
    redirect_to entries_url
  end
end
