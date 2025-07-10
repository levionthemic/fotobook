class FeedController < ApplicationController
  def index
    @tab = params[:tab]
    unless params[:tab]
      @tab = "photos"
    end

    @items = []

    if @tab == "photos"
      if user_signed_in?
        current_user.followings.each do |following|
          following.photos.each do |photo|
            if photo.sharing_mode == "public_mode"
              @items << photo
            end
          end
        end
        @items.sort! { |a, b| b.created_at <=> a.created_at }
      else
        @items = Photo.where(sharing_mode: "public_mode")
      end
    else
      @items = Album.where(sharing_mode: "public_mode")
    end

  end

  def show_discover
    @tab = params[:tab]
    unless params[:tab]
      @tab = "photos"
    end
    @items = []

    if @tab == "photos"
      @items = Photo.where(sharing_mode: "public_mode").where.not(user_id: current_user.id).order(created_at: :desc)
    else
      @items = Album.all.limit(10)
    end
  end
end
