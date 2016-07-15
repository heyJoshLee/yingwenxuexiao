class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
      if @user.save
        flash[:success] = "You have successfully registered. You are now logged in."
        session[:user_id] = @user.id
        redirect_to blog_path
      else
        flash.now[:error] = "Your account was not created."
        render :new
      end
    end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password)
  end

end