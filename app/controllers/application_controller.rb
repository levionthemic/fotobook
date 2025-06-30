class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # helper_method :current_user, :logged_in?

  # private

  # def current_user
  #   @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  # end

  # def logged_in?
  #   current_user.present?
  # end

  # def require_login
  #   unless logged_in?
  #     flash[:alert] = "Bạn cần đăng nhập để tiếp tục"
  #     redirect_to login_path
  #   end
  # end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [ :first_name, :last_name, :email, :password, :password_confirmation, :remember_me ]

    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
end
