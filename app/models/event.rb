class Event < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :entries, through: :teams
  has_many :users, through: :teams

  validates :start_time, :end_time, :title, :theme, presence: :true
  validates :start_time, comparison: { less_than: :end_time }

  scope :published, -> { where(published: true) }
  scope :future, -> { where("end_time >= ?", Time.current) }
  scope :past, -> { where("end_time < ?", Time.current) }
  scope :newest_first, -> { order(end_time: :desc) }

  attribute :start_time, default: 1.month.from_now
  attribute :end_time, default: 2.months.from_now
  attribute :published, default: true

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
    persisted? ? [id, title.parameterize].join("-") : nil
  end

  def active?
    end_time.future?
  end

  def future?
    start_time.future?
  end

  def started?
    start_time.past?
  end

  def ended?
    end_time.past?
  end

  def start_date
    start_time.to_date
  end

  def end_date
    end_time.to_date
  end

  def running?
    started? && !ended?
  end
end
