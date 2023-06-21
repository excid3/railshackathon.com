class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_many :votes, dependent: :destroy
  has_many :services, dependent: :destroy
  has_one :team_user, dependent: :destroy
  has_one :team, ->{ where(event: Event.latest) }, through: :team_user

  has_one_attached :avatar
  has_person_name

  validates :name, presence: true

  def github
    services.github.first&.username
  end

  def voted_for_entry?(entry:)
    votes.where(entry_id: entry.id).any?
  end

  def vote_for_entry(entry)
    votes.find_by(entry_id: entry.id)
  end
end
