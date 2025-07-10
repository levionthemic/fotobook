# frozen_string_literal: true

class LikesController < ApplicationController
  include ActionView::RecordIdentifier
  def create
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
    current_user.likes.create!(likeable: @likeable)

    photo_ids = Photo.includes(:user).where(sharing_mode: "public_mode").where.not(user_id: current_user.id).order(created_at: :desc).pluck(:id)

    @likes_by_user = Like.where(
      user_id: current_user.id,
      likeable_type: "Photo",
      likeable_id: photo_ids
    ).pluck(:id, :likeable_id).to_set

    @like_counts = Like.where(
      likeable_type: "Photo",
      likeable_id: photo_ids
    ).group(:likeable_id).count

    render_like_section
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @likeable = @like.likeable
    @like.destroy

    photo_ids = Photo.includes(:user).where(sharing_mode: "public_mode").where.not(user_id: current_user.id).order(created_at: :desc).pluck(:id)

    @likes_by_user = Like.where(
      user_id: current_user.id,
      likeable_type: "Photo",
      likeable_id: photo_ids
    ).pluck(:id, :likeable_id).to_set

    @like_counts = Like.where(
      likeable_type: "Photo",
      likeable_id: photo_ids
    ).group(:likeable_id).count

    render_like_section
  end

  private

  def render_like_section
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          dom_id(@likeable, :like_section),
          partial: "likes/like_section",
          locals: { item: @likeable }
        )
      end
      format.html { redirect_to request.referer || root_path }
    end
  end
end
