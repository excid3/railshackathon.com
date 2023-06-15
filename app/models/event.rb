class Event < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :entries, through: :teams
  
  validates :start_time, :end_time, :theme, presence: :true
  validates :start_time, comparison: { less_than: :end_time }
  
  scope :published, -> { where(published: true) }

  def self.current
    published.where("end_time > ?", Time.current).order(end_time: :asc).take
  end

  def self.previous
    published.where("end_time < ?", Time.current).order(end_time: :desc).take
  end
  
  def to_param
    [id, title.parameterize].join("-")
  end
  
  def active?
    end_time.after? Time.current
  end
end
