class PasswordResetsController < ApplicationController

  before_action :set_password_reset_token, only: [:new, :show]
  before_action :set_user, only: [:create]

  def show
    redirect_to expired_password_token_path  unless @password_reset_token
  end

  def create
    if params[:password].blank?
      flash[:danger] = "密碼未更新。"
      # flash[:danger] = "Password was not updated."
      redirect_to password_reset_path(params[:password_reset_token])
    else
      @user.password = params[:password]
      @user.generate_password_reset_token
      if @user.save
        flash[:success] = "密碼已更新。"
        # flash[:success] = "Password has been updated."
        redirect_to sign_in_path
      else 
        flash[:danger] = "密碼未更新。"
        # flash[:danger] = "Password was not updated."
        redirect_to password_reset_url(params[:password_reset_token])
      end
    end

  end

  def expired
    
  end

  private

  def set_password_reset_token
    @password_reset_token = User.find_by(password_reset_token: params[:id]).password_reset_token
  end

  def set_user
    @user = User.find_by(password_reset_token: params[:password_reset_token])
  end


end