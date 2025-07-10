class FeedController < ApplicationController
  def index
    @tab = params[:tab]
    unless params[:tab]
      @tab = "photos"
    end

    @items = []

    if @tab == "photos"
      if user_signed_in?
        @items = Photo.includes(:user).where(sharing_mode: "public_mode").where.not(user_id: current_user.id).order(created_at: :desc)
        photo_ids = @items.map(&:id)
        user_ids = @items.map(&:user_id)

        @likes_by_user = Like.where(
          user_id: current_user.id,
          likeable_type: "Photo",
          likeable_id: photo_ids
        ).pluck(:id, :likeable_id).to_set

        @like_counts = Like.where(
          likeable_type: "Photo",
          likeable_id: photo_ids
        ).group(:likeable_id).count
      else
        @items = Photo.includes(:user).where(sharing_mode: "public_mode").order(created_at: :desc)
      end
    else
      @items = Album.includes(:user).where(sharing_mode: "public_mode").order(created_at: :desc)
    end

  end

  def show_discover
    @tab = params[:tab] || "photos"

    if @tab == "photos"
      @items = Photo.includes(:user)
                    .where(sharing_mode: "public_mode")
                    .where.not(user_id: current_user.id)
                    .order(created_at: :desc)

      photo_ids = @items.map(&:id)
      user_ids = @items.map(&:user_id)

      @likes_by_user = Like.where(
        user_id: current_user.id,
        likeable_type: "Photo",
        likeable_id: photo_ids
      ).pluck(:id, :likeable_id).to_set

      @like_counts = Like.where(
        likeable_type: "Photo",
        likeable_id: photo_ids
      ).group(:likeable_id).count

      @followings = Follow.where(
        follower_id: current_user.id,
        following_id: user_ids
      ).pluck(:following_id).to_set
    else
      @items = Album.all.limit(10)
    end
  end

end
