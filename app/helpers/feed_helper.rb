module FeedHelper
  def count_likes(item_id)
    @like_count[item_id] || 0
  end

  def is_liked?(user_id, item_id)
    @likes_by_user.any? { |_, likeable_id| likeable_id.to_i == item_id.to_i }
  end

  def get_like_id(item_id)
    @likes_by_user.select { |_, likeable_id| likeable_id.to_i == item_id.to_i }.first
  end

  def following?(user_id)
    if @followings
      @followings.include?(user_id)
    else
      false
    end
  end
end
