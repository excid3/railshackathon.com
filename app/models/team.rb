class Team < ApplicationRecord
  MAXIMUM_PER_TEAM = 4

  has_one :entry, dependent: :destroy
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users

  has_rich_text :description

  validates :name, presence: true, uniqueness: true
  validates :time_zone, presence: true

  def find_or_create_repository
    repo_name = Rails.env.dev? ? "dev-#{repo_name}" : "team-#{id}"
    client = Octokit::Client.new(access_token: Github.new.access_token)
    client.create_repository(repo_name, organization: "rails-hackathon", private: true)
    update(github_repo: "rails-hackathon/#{repo_name}")
  rescue
  end

  def add_collaborator(username)
    client = Octokit::Client.new(access_token: Github.new.access_token)
    client.add_collaborator(github_repo, username, permission: :maintain)
  end

  def team_member?(user)
    users.include?(user)
  end

  def full?
    team_users.where.not(id: nil).size >= MAXIMUM_PER_TEAM
  end
end
