class TeamUser < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validate :maximum_team_members
  after_destroy :cleanup_team

  after_create_commit do
    team.add_github_collaborator(user.github)
  end

  after_destroy_commit do
    team.remove_github_collaborator(user.github)
  end

  def maximum_team_members
    if team.team_users.size > Team::MAXIMUM_PER_TEAM
      errors.add(:base, "Sorry, this team is full")
    end
  end

  def cleanup_team
    team.destroy if team.team_users.size.zero?
  end
end
