# frozen_string_literal: true

module Admin
  class PhotosController < ApplicationController
    ITEMS_PER_PAGE = 40

    include AdminMethods

    load_and_authorize_resource
    before_action :get_photo, only: [:edit, :update, :destroy]

    def index
      @photos = Photo.page(params[:page]).per(ITEMS_PER_PAGE)
    end

    def edit
    end

    def update
      if @photo.update(photo_params)
        redirect_to admin_photos_path, notice: "Photo was successfully updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @photo.destroy
        redirect_to admin_photos_path, notice: "Delete photo successfully!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def photo_params
      params.require(:photo).permit(:title, :description, :sharing_mode, :image)
    end

    def get_photo
      @photo = Photo.find(params[:id])
    end
  end
end
