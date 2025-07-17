class PhotosController < ApplicationController
  # before_action :set_photo, only: %i[ show edit update destroy ]

  # GET /photos or /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1 or /photos/1.json
  def show
    @user_id = params[:id]
  end

  # GET /photos/new
  def new
    @photo = Photo.new
    @user_id = params[:user_id]
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos or /photos.json
  def create
    @user = User.find(params[:user_id])
    @photo = @user.photos.build(photo_params)
    if @photo.save
      redirect_to user_path(current_user.id), notice: "Create photo successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /photos/1 or /photos/1.json
  def update
    @photo = Photo.find(params[:id])

    if @photo.update(photo_params)
      redirect_to user_path(current_user.id), notice: "Edit photo successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /photos/1 or /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      redirect_to user_path(current_user.id), notice: "Delete photo successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = Photo.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def photo_params
    params.require(:photo).permit(:title, :description, :sharing_mode, :image)
  end
end
