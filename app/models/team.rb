class Team < ApplicationRecord
  MAXIMUM_PER_TEAM = 4

  has_one :entry, dependent: :destroy
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users

  has_rich_text :description

  validates :name, presence: true, uniqueness: true
  validates :time_zone, presence: true

  after_create_commit :find_or_create_repository
  after_create_commit :add_all_collaborators
  after_destroy_commit :delete_repository

  def repo_name
    Rails.env.development? ? "dev-team-#{id}" : "team-#{id}"
  end

  def team_member?(user)
    users.include?(user)
  end

  def full?
    team_users.where.not(id: nil).size >= MAXIMUM_PER_TEAM
  end

  def find_or_create_repository
    github_client.create_repository(repo_name, organization: "rails-hackathon", private: true)
    update(github_repo: "rails-hackathon/#{repo_name}")
  rescue
  end

  def delete_repository
    github_client.delete_repository(github_repo)
  end

  def add_all_collaborators
    users.joins(:services).each do |user|
      add_github_collaborator(user.github)
    end
  end

  def add_github_collaborator(username)
    github_client.add_collaborator(github_repo, username, permission: :maintain)
  end

  def remove_github_collaborator(username)
    github_client.add_collaborator(github_repo, username, permission: :maintain)
  end

  def github_client
    Octokit::Client.new(access_token: Github.new.access_token)
  end
end
