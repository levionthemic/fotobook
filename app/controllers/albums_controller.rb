class AlbumsController < ApplicationController
  def new
    @user_id = params[:user_id]
    @album = Album.new
  end

  def edit
    @album = Album.find(params[:id])
  end

  def create
    photo_ids = String(album_params[:selected_photo_ids]).split(",")
    @album = current_user.albums.new(album_params.except(:selected_photo_ids))
    if @album.save
      AlbumPhoto.insert_all(photo_ids.map { |pid| { album_id: @album.id, photo_id: pid.to_i } })
      redirect_to user_path(current_user.id), notice: "Create album successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    photo_ids = String(album_params[:selected_photo_ids]).split(",")

    # Delete all photos not in album
    AlbumPhoto.where(album_id: params[:id]).delete_all
    AlbumPhoto.insert_all(photo_ids.map { |pid| { album_id: params[:id], photo_id: pid.to_i } })

    @album = Album.find(params[:id])
    if @album.update(album_params.except(:selected_photo_ids))
      redirect_to user_path(current_user.id, tab: "albums"), notice: "Edit album successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @album = Album.find(params[:id])
    if @album.destroy
      redirect_to user_path(current_user.id, tab: "albums"), notice: "Delete album successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def album_params
    params.require(:album).permit(:title, :description, :sharing_mode, :selected_photo_ids)
  end
end
