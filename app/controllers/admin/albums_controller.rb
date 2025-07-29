# frozen_string_literal: true

module Admin
  class AlbumsController < ApplicationController
    ITEMS_PER_PAGE = 40

    include AdminMethods

    load_and_authorize_resource
    before_action :get_album, only: [:edit, :update, :destroy]

    def index
      @albums = Album.page(params[:page]).per(ITEMS_PER_PAGE)
    end

    def edit
    end

    def update
      photo_ids = String(album_params[:selected_photo_ids]).split(",")

      # Delete all photos not in album
      AlbumPhoto.where(album_id: params[:id]).delete_all
      AlbumPhoto.insert_all(photo_ids.map { |pid| { album_id: params[:id], photo_id: pid.to_i } })

      if @album.update(album_params.except(:selected_photo_ids))
        redirect_to admin_albums_path, notice: "Edit album successfully!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      if @album.destroy
        redirect_to admin_albums_path, notice: "Delete album successfully!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def album_params
      params.require(:album).permit(:title, :description, :sharing_mode, :selected_photo_ids)
    end

    def get_album
      @album = Album.find(params[:id])
    end
  end
end
