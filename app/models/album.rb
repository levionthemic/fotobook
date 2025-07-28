class Album < ApplicationRecord
  default_scope { where(sharing_mode: :public_mode) }

  belongs_to :user

  enum :sharing_mode, { public_mode: 0, private_mode: 1 }

  has_many :album_photos, dependent: :destroy
  has_many :photos, through: :album_photos

  has_many :likes, as: :likeable, dependent: :destroy
end
