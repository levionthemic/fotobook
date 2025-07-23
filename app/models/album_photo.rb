class AlbumPhoto < ApplicationRecord
  belongs_to :album
  belongs_to :photo

  validates :album_id, uniqueness: { scope: :photo_id }
end
