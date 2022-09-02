class TeamUser < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validate :maximum_team_members

  def maximum_team_members
    if team.team_users.where.not(id: nil).size >= Team::MAXIMUM_PER_TEAM
      errors.add(:base, "Sorry, this team is full")
    end
  end
end
