module FollowsHelper
  def following?(user_id)
    Follow.exists?(follower_id: current_user.id, following_id: user_id)
  end
end
