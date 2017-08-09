class ForgotPasswordsController < ApplicationController

  def expired
    
  end
  
  def create
    email_input = params[:email]
     user = User.find_by(email: email_input)
    if user
      user.generate_password_reset_token
      SendForgotPasswordEmailWorker.perform_async(user.id)
      redirect_to forgot_password_confirmation_path
    else
      flash[:danger] = email_input.blank? ? "Email cannot be blank." : "Cannot find email."
      redirect_to new_forgot_password_path
    end
  end

end