class Entry < ApplicationRecord
  belongs_to :team
  has_many_attached :screenshots
  has_rich_text :description
  has_rich_text :built_with

  validates :title, presence: true, uniqueness: true
end
