class UserMailer < ApplicationMailer
  def warning_inactive_mail(user)
    @user = user
    mail(to: @user.email, subject: "Your Fotobook account is inactive so you cannot log in now. Please contact Admin for more information!")
  end
end
