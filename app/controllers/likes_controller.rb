# frozen_string_literal: true

class LikesController < ApplicationController
  load_and_authorize_resource
  include ActionView::RecordIdentifier

  def create
    @tab = params[:tab] || "photos"
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
    current_user.likes.create!(likeable: @likeable)

    @likes_by_user = Like.where(
      user_id: current_user.id,
      likeable_type: params[:likeable_type],
      likeable_id: params[:likeable_id].to_i
    ).pluck(:id, :user_id)

    @like_count = Like.where(
      likeable_type: params[:likeable_type],
      likeable_id: params[:likeable_id].to_i
    ).count

    render_like_section
  end

  def destroy
    @tab = params[:tab] || "photos"
    @like = current_user.likes.find(params[:id])
    @likeable = @like.likeable

    likeable_id = @like.likeable_id
    @like.destroy

    @likes_by_user = Like.where(
      user_id: current_user.id,
      likeable_type: @tab === "photos" ? "Photo" : "Album",
      likeable_id: likeable_id
    ).pluck(:id, :user_id)

    @like_count = Like.where(
      likeable_type: @tab === "photos" ? "Photo" : "Album",
      likeable_id: likeable_id
    ).count

    puts params.inspect

    render_like_section
  end

  private

  def render_like_section
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          dom_id(@likeable, :like_section),
          partial: "likes/like_section",
          locals: { item: @likeable, tab: @tab }
        )
      end
      format.html { redirect_to request.referer || root_path }
    end
  end
end
