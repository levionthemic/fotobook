class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]


  def self.from_omniauth(auth)
    User.create(
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      provider: auth.provider,
      uid: auth.uid,
      password: Devise.friendly_token[0, 20]
    )
  end

  # CarrierWave + Cloudinary
  mount_uploader :avatar, AvatarUploader

  enum :role, { guest: 0, user: 1, admin: 2 }
  enum :status, { active: 0, inactive: 1 }

  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 25 }

  has_many :photos, dependent: :destroy
  has_many :albums, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :active_follows, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :active_follows, source: :following

  has_many :passive_follows, class_name: "Follow", foreign_key: :following_id, dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

end
