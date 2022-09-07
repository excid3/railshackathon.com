class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :services, dependent: :destroy
  has_one :team_user, dependent: :destroy
  has_one :team, through: :team_user

  has_one_attached :avatar
  has_person_name
  has_noticed_notifications

  validates :name, presence: true
  validates :email, presence: true, format: { with: Devise.email_regexp }
end
