class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :entry, counter_cache: true
  has_one :team, through: :entry
  has_one :event, through: :team

  acts_as_list scope: :user

  validates :entry_id, uniqueness: {scope: :user_id}
  validate :user_can_have_only_five_votes

  MAXIMUM = 5

  def user_can_have_only_five_votes
    # Using size here will count the in-memory instances plus the db records
    # If you have 5 vote records in the database and try to create a 6th record
    # this validation will fail. However, if you are only updating the order of your
    # existing votes the validation will pass because there is no in-memory instance.
    if user.votes.joins(:event).where(events: {id: event.id}).size > MAXIMUM
      errors.add(:base, "You've reached the #{MAXIMUM} vote limit")
    end
  end
end
