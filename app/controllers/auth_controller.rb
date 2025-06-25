class AuthController < ApplicationController
  def login
  end

  def loginPost
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Đăng nhập thành công!"
    else
      flash.now[:alert] = "Email hoặc mật khẩu không đúng!"
      render :login, status: :unprocessable_entity
    end
  end

  def signup
  end

  def signupPost
    user = User.find_by(email: params[:email])
    if user
      flash.now[:alert] = "Email đã tồn tại!"
      render :signup, status: :unprocessable_entity
      return
    end

    password = params[:password]
    password_confirm = params[:password_confirm]
    if !password.eql?(password_confirm)
      flash.now[:alert] = "Mật khẩu xác nhận không trùng khớp!"
      render :signup, status: :unprocessable_entity
      return
    end
    user = User.new(name: params[:name], email: params[:email], password: params[:password])
    if user.save
      flash[:notice] = "Đăng ký thành công! Hãy đăng nhập để tiếp tục."
      redirect_to login_path
    else
      flash.now[:alert] = "Đăng ký thất bại! Vui lòng kiểm tra lại thông tin!"
      render :signup, status: :internal_server_error
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to root_path, notice: "Đã đăng xuất"
  end
end
