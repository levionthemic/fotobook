class Photo < ApplicationRecord
  mount_uploader :image, PhotoUploader

  belongs_to :user

  enum :sharing_mode, { public_mode: 0, private_mode: 1 }

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :album_photos, dependent: :destroy
  has_many :albums, through: :album_photos

  has_many :notifications, as: :notifiable, dependent: :destroy
end
