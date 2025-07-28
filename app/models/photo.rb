class Photo < ApplicationRecord
  mount_uploader :image, PhotoUploader
  scope :public_m, -> { where(sharing_mode: :public_mode) }

  belongs_to :user

  enum :sharing_mode, { public_mode: 0, private_mode: 1 }

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :album_photos, dependent: :destroy
  has_many :albums, through: :album_photos

  validates :image, presence: true, on: :create
  validates :sharing_mode, presence: true
  validates :description, presence: true
  validates :title, presence: true
end
