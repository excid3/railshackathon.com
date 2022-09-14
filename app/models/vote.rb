class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :entry

  acts_as_list scope: :user

  validate :user_can_have_only_five_votes

  MAXIMUM = 5

  def user_can_have_only_five_votes
    if user.votes.count >= MAXIMUM
      errors.add(:base, "You've reached the #{MAXIMUM} vote limit")
    end
  end
end
