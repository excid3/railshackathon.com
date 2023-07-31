class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :entry, counter_cache: true
  belongs_to :event
  has_one :team, through: :entry

  acts_as_list scope: [:user_id, :event_id]

  validates :entry_id, uniqueness: {scope: :user_id}
  validate :user_can_have_only_five_votes

  MAXIMUM = 5

  def user_can_have_only_five_votes
    if user.votes.where(event: event).size >= MAXIMUM
      errors.add(:base, "You've reached the #{MAXIMUM} vote limit")
    end
  end
end
