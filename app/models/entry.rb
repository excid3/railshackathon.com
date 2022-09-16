class Entry < ApplicationRecord
  belongs_to :team
  has_many :votes, dependent: :destroy
  has_many_attached :screenshots
  has_rich_text :description
  has_rich_text :built_with

  validates :title, presence: true, uniqueness: true
  validates :website_url, presence: true
  validates :description, presence: true
  validates :built_with, presence: true

  after_initialize do
    self.github_url ||= "https://github.com/rails-hackathon/#{team.repo_name}"
  end
end
