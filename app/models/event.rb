class Event < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :entries, through: :teams

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
    end_time.after? Time.current
  end

  def future?
    Time.current.before? start_time
  end

  def started?
    Time.current.after? start_time
  end

  def ended?
    Time.current.after? end_time
  end

  def running?
    started? && !ended?
  end

  def start_date
    start_time.to_date
  end

  def end_date
    end_time.to_date
  end
end
