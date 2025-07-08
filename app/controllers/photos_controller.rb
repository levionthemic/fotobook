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
    @photo = Photo.new(title: params[:title], description: params[:description], sharing_mode: params[:sharing_mode], image: params[:image], user_id: current_user.id)
    if @photo.save
      puts "✅ Save thành công"
      puts "URL ảnh: #{@photo.image.url}"
      redirect_to user_path(current_user.id), notice: "Create photo successfully!"
    else
      puts "❌ Save lỗi: #{@photo.errors.full_messages}"
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /photos/1 or /photos/1.json
  def update
    @photo = Photo.find(params[:id])
    permitted = {
      title: params[:title],
      description: params[:description],
      sharing_mode: params[:sharing_mode]
    }

    permitted[:image] = params[:image] if params[:image].present?

    if @photo.update(permitted)
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

  # --------------------------------------------------
  def admin_show_photos
    @photos = Photo.all.limit(12)
    render "admin/photos"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = Photo.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def photo_params
    params.expect(photo: [:title, :description, :sharing_mode, :image])
  end
end
