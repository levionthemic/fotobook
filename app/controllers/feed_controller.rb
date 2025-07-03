class FeedController < ApplicationController
  def index
    @tab = params[:tab]
    if !params[:tab]
      @tab = "photos"
    end

    if @tab == "photos"
      @items = Photo.where(sharing_mode: "public_mode")
    else
      @items = Album.where(sharing_mode: "public_mode")
    end
  end

  def show_discover
     @tab = params[:tab]
    if !params[:tab]
      @tab = "photos"
    end

    if @tab == "photos"
      @items = Photo.all.limit(10)
    else
      @items = Album.all.limit(10)
    end
  end
end
