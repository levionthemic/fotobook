class AlbumsController < ApplicationController
  def new
    @user_id = params[:user_id]
  end

  def edit
    @album = Album.find(params[:id])
  end

  # --------------------------------------------------
  def admin_show_albums
    @albums = Album.all.limit(10)
    render "admin/albums"
  end
end
