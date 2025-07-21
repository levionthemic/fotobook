# frozen_string_literal: true

module Admin
  class PhotosController < ApplicationController
    before_action :check_admin_only
    def index
      @photos = Photo.all.page(params[:page]).per(10)
    end

    def edit
      @photo = Photo.find(params[:id])
    end

    def update
      @photo = Photo.find(params[:id])
      if @photo.update(photo_params)
        redirect_to admin_photos_path, notice: "Photo was successfully updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def photo_params
      params.require(:photo).permit(:title, :description, :sharing_mode, :image)
    end

    def check_admin_only
      unless current_user&.admin?
        redirect_to root_path, alert: "Bạn không có quyền truy cập trang admin."
      end
    end
  end
end
