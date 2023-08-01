class Entry < ApplicationRecord
  include Points

  belongs_to :team
  has_one :event, through: :team
  has_many :votes, dependent: :destroy
  has_many_attached :screenshots
  has_rich_text :description
  has_rich_text :built_with

  scope :newest_first, -> {order(created_at: :desc)}
  scope :by_completed_status, -> { in_order_of(:complete, [true, false]) }
  scope :by_title, -> { order("LOWER(title)") }

  validates :title, presence: true, uniqueness: {scope: :team_id}
  validates :website_url, presence: true
  validates :description, presence: true
  validates :built_with, presence: true

  broadcasts_to :event

  after_initialize do
    self.github_url ||= "https://github.com/rails-hackathon/#{team.repo_name}"
  end
end
