class FeedController < ApplicationController
  def index
    @photos = Photo.all.limit(10)
  end

  def show_discover
  end
end
