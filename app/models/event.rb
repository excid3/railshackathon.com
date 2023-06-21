class Event < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :entries, through: :teams

  validates :start_time, :end_time, :title, :theme, presence: :true
  validates :start_time, comparison: { less_than: :end_time }

  scope :published, -> { where(published: true) }
  scope :future, -> { where("end_time >= ?", Time.current) }
  scope :past, -> { where("end_time < ?", Time.current) }
  scope :newest_first, -> { order(end_time: :desc) }

  def self.latest
    current || previous
  end

  def self.current
    future.published.order(end_time: :asc).first
  end

  def self.previous
    past.published.newest_first.first
  end

  def to_param
    [id, title.parameterize].join("-")
  end

  def active?
    end_time.after? Time.current
  end
end
