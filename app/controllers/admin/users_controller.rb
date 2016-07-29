class Admin::UsersController < AdminController

  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_admin
  
  def new
    @user = User.new
  end

  def readers
    @users = User.where(role: "reader")
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "user was saved"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "There was a problem and the user was not saved"
      render :new
    end
  end

  private

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def user_params
    params.require(:user).permit!
  end

end