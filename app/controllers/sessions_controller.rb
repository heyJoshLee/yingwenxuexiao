class SessionsController < ApplicationController

  def new
    redirect_to blog_path if logged_in?
  end

  def create
    redirect_to blog_path if logged_in?

    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "您已登入" # You are signed in.
      redirect_to blog_path
    else
      flash.now[:danger] = "There was something wrong with your email or password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = "您已登出" # You are now logged out
    redirect_to blog_path
  end

end

