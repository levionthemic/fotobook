module FeedHelper
  def count_likes(photo_id)
    @like_count[photo_id] || 0
  end

  def is_liked?(user_id, photo_id)
    @likes_by_user.any? { |_, likeable_id| likeable_id.to_i == photo_id.to_i }
  end

  def get_like_id(photo_id)
    @likes_by_user.select { |_, likeable_id| likeable_id.to_i == photo_id.to_i }.first
  end

  def following?(user_id)
    if @followings
      @followings.include?(user_id)
    else
      false
    end
  end
end
