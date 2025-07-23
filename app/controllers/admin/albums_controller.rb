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

    def check_admin_only
      unless current_user&.admin?
        redirect_to root_path, alert: "Bạn không có quyền truy cập trang admin."
      end
    end
  end
end
