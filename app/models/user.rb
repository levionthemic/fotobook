class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  enum :role, { guest: 0, user: 1, admin: 2 }
  enum :status, { active: 0, inactive: 1 }

  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name,  presence: true, length: { maximum: 25 }

  has_many :photos, dependent: :destroy
  has_many :albums, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy  # người nhận

  has_many :active_follows, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
  has_many :passive_follows, class_name: "Follow", foreign_key: :following_id, dependent: :destroy

  has_many :followings, through: :active_follows, source: :following
  has_many :followers, through: :passive_follows, source: :follower

  has_many :sent_notifications, class_name: "Notification", foreign_key: :notifier_id, dependent: :destroy
end
