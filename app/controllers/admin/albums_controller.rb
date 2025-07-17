# frozen_string_literal: true

module Admin
  class AlbumsController < ApplicationController
    def index
      @albums = Album.all.page(params[:page]).per(10)
    end

    def edit
      @album = Album.find(params[:id])
    end

    def update
      @album = Album.find(params[:id])
      if @album.update(album_params)
        redirect_to admin_albums_path, notice: "Album was successfully updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def album_params
      Album.require(:album).permit(:title, :description, :sharing_mode)
    end
  end
end
