class FeedController < ApplicationController
  before_action :set_shared_data
  before_action :check_user_only

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

    user_ids = @items.map(&:user_id)

    if user_signed_in?
      @followings = Follow.where(
        follower_id: current_user.id,
        following_id: user_ids
      ).pluck(:following_id).to_set

      @items = @items.select { |item| @followings.include?(item.user.id) }
      @items = Kaminari.paginate_array(@items).page(params[:page]).per(6)
    else
      @items = @items.page(params[:page]).per(6)
      end

    @is_discover = false

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show_discover
    authorize! :read, current_user unless current_user.user?
    @tab = params[:tab] || "photos"

    if @tab == "photos"
      @items = @photos

      user_ids = @items.map(&:user_id)

      @followings = Follow.where(
        follower_id: current_user.id,
        following_id: user_ids
      ).pluck(:following_id).to_set
    else
      @items = Album.includes(:user).where(sharing_mode: "public_mode").order(created_at: :desc)
    end

    @items = @items.page(params[:page]).per(6)

    @is_discover = true

    respond_to do |format|
      format.html
      format.turbo_stream
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

  def check_user_only
    unless !current_user || current_user.user?
      redirect_to admin_root_path, alert: "Bạn không có quyền truy cập trang này."
    end
  end

end
