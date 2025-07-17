# frozen_string_literal: true

module Admin
  class PhotosController < ApplicationController
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
  end
end
