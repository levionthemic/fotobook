class PhotosController < ApplicationController
  def index

  end

  def new
    @photo = Photo.new
    @user_id = params[:user_id]
  end

  def create
    @user = User.find(params[:user_id])
    @photo = @user.photos.new(photo_params)
    if @photo.save
      redirect_to user_path(current_user.id), notice: "Create photo successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])

    if @photo.update(photo_params)
      redirect_to user_path(current_user.id), notice: "Edit photo successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      redirect_to user_path(current_user.id), notice: "Delete photo successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :description, :sharing_mode, :image)
  end
end
