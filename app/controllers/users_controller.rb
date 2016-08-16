class UsersController < ApplicationController

  before_filter :set_user, only: [:show, :edit, :update]

  before_filter :require_user

  def new
    @user = User.new
  end

  def show
    add_breadcrumb "Account"
    @user = current_user
  end

  def edit
    add_breadcrumb "Account", account_path
    add_breadcrumb "Edit"
  end

  def create
    @user = User.new(user_params)
    @user.points = 0
    @user.level = 1
    
    if @user.save
      flash[:success] = "You have successfully registered. You are now logged in."
      session[:user_id] = @user.id
      redirect_to blog_path
    else
      flash.now[:error] = "Your account was not created."
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile saved successfully"
      redirect_to edit_user_path(@user)
    else
      flash.now[:danger] = "There was an error and nothing was saved"
      render :edit
    end

  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :picture_url)
  end

end