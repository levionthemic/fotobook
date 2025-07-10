module FeedHelper
  def count_likes(photo_id)
    Like.where(likeable_type: "Photo", likeable_id: photo_id).count
  end

  def is_liked?(user_id, photo_id)
    Like.where(likeable_type: "Photo", likeable_id: photo_id, user_id: user_id).exists?
  end
end
