class FeedController < ApplicationController
  before_action :set_shared_data

  def index
    @tab = params[:tab]
    unless params[:tab]
      @tab = "photos"
    end

    @items = []

    if @tab == "photos"
      if user_signed_in?
        @items = @photos
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
      @items = @photos

      user_ids = @items.map(&:user_id)

      @followings = Follow.where(
        follower_id: current_user.id,
        following_id: user_ids
      ).pluck(:following_id).to_set
    else
      @items = Album.all.limit(10)
    end
  end

  private

  def set_shared_data
    if user_signed_in?
      @photos = Photo.includes(:user)
                     .where(sharing_mode: "public_mode")
                     .where.not(user_id: current_user.id)
                     .order(created_at: :desc)

      photo_ids = @photos.map(&:id)

      @likes_by_user = Like.where(
        user_id: current_user.id,
        likeable_type: "Photo",
        likeable_id: photo_ids
      ).pluck(:id, :likeable_id).to_set

      @like_count = Like.where(
        likeable_type: "Photo",
        likeable_id: photo_ids
      ).group(:likeable_id).count
    else
      @photos = Photo.includes(:user)
                     .where(sharing_mode: "public_mode")
                     .order(created_at: :desc)

      photo_ids = @photos.map(&:id)

      @like_count = Like.where(
        likeable_type: "Photo",
        likeable_id: photo_ids
      ).group(:likeable_id).count
    end
  end

end
