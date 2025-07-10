# frozen_string_literal: true

class LikesController < ApplicationController
  include ActionView::RecordIdentifier  # 👈 thêm dòng này
  def create
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
    current_user.likes.create!(likeable: @likeable)
    render_like_section
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @likeable = @like.likeable
    @like.destroy
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
