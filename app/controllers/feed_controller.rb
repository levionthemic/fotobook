class FeedController < ApplicationController
  before_action :check_user_only
  before_action :get_tab_and_model
  skip_before_action :authenticate_user!, only: [:index]

  ITEMS_PER_PAGE = 6

  def index
    @items = @model.constantize.includes(:user).public_m.order(created_at: :desc)
    if user_signed_in?
      @items = @items.where.not(user_id: current_user.id)
      @likes_by_user = Like.where(
        user_id: current_user.id,
        likeable_type: @model,
        likeable_id: @items.map(&:id)
      ).pluck(:id, :likeable_id).to_set
    end
    @like_count = Like.where(
      likeable_type: @model,
      likeable_id: @items.map(&:id)
    ).group(:likeable_id).count

    user_ids = @items.map(&:user_id)

    if user_signed_in?
      @followings = Follow.where(
        follower_id: current_user.id,
        following_id: user_ids
      ).pluck(:following_id).to_set

      @items = @items.select { |item| @followings.include?(item.user.id) }
      @items = Kaminari.paginate_array(@items).page(params[:page]).per(6)
    else
      @items = @items.page(params[:page]).per(ITEMS_PER_PAGE)
    end

    @is_discover = false

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show_discover
    authorize! :read, current_user unless current_user.user?

    @items = @model.constantize.includes(:user)
                  .public_m
                  .where.not(user_id: current_user.id)
                  .order(created_at: :desc)
    photo_ids = @items.map(&:id)
    @likes_by_user = Like.where(
      user_id: current_user.id,
      likeable_type: @model,
      likeable_id:@items.map(&:id)
    ).pluck(:id, :likeable_id).to_set
    @like_count = Like.where(
      likeable_type: @model,
      likeable_id: @items.map(&:id)
    ).group(:likeable_id).count

    user_ids = @items.map(&:user_id)

    @followings = Follow.where(
      follower_id: current_user.id,
      following_id: user_ids
    ).pluck(:following_id).to_set

    @items = @items.page(params[:page]).per(ITEMS_PER_PAGE)

    @is_discover = true

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  private

  def check_user_only
    unless !current_user || current_user.user?
      redirect_to admin_root_path, alert: "Bạn không có quyền truy cập trang này."
    end
  end

  def get_tab_and_model
    @tab = params[:tab] || "photos"
    @model = @tab == "photos" ? "Photo" : "Album"
  end

end
