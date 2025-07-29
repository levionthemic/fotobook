# app/controllers/concerns/shared_methods.rb
module AdminMethods
  extend ActiveSupport::Concern

  private

  def check_admin_only
    unless current_user&.admin?
      redirect_to root_path, alert: "Bạn không có quyền truy cập trang admin."
    end
  end
end
