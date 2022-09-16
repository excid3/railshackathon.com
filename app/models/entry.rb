class Entry < ApplicationRecord
  include Points

  belongs_to :team
  has_many :votes, dependent: :destroy
  has_many_attached :screenshots
  has_rich_text :description
  has_rich_text :built_with

  validates :title, presence: true, uniqueness: true

  scope :order_by_total_points, -> { order(total_points: :desc) }
end
