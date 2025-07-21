class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    auth = request.env["omniauth.auth"]
    action_type = session.delete("oauth_action_type")

    @user = User.find_by(email: auth.info.email)

    if action_type == "login"
      if @user
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
      else
        redirect_to new_user_session_path, alert: "Tài khoản chưa được đăng ký. Vui lòng đăng ký trước."
      end

    elsif action_type == "signup"
      if @user
        redirect_to new_user_session_path, alert: "Email đã tồn tại. Vui lòng đăng nhập."
      else
        @user = User.from_omniauth(auth)
        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
        else
          session["devise.google_data"] = auth.except(:extra)
          redirect_to new_user_registration_url, alert: "Không thể tạo tài khoản."
        end
      end

    else
      # fallback: login/signup tự động nếu không có session
      @user = User.from_omniauth(auth)

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
      else
        session["devise.google_data"] = auth.except(:extra)
        redirect_to new_user_registration_url
      end
    end
  end

end