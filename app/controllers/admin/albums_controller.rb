# frozen_string_literal: true

module Admin
  class AlbumsController < ApplicationController
    load_and_authorize_resource
    before_action :check_admin_only
    def index
      @albums = Album.all.page(params[:page]).per(10)
    end

    def edit
      @album = Album.find(params[:id])
    end

    def update
      photo_ids = String(album_params[:selected_photo_ids]).split(",")

      # Delete all photos not in album
      AlbumPhoto.where(album_id: params[:id]).delete_all
      AlbumPhoto.insert_all(photo_ids.map { |pid| { album_id: params[:id], photo_id: pid.to_i } })

      @album = Album.find(params[:id])
      if @album.update(title: album_params[:title], description: album_params[:description], sharing_mode: album_params[:sharing_mode])
        redirect_to admin_albums_path, notice: "Edit album successfully!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @album = Album.find(params[:id])
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

    def check_admin_only
      unless current_user&.admin?
        redirect_to root_path, alert: "Bạn không có quyền truy cập trang admin."
      end
    end
  end
end
