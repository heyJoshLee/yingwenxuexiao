class UsersController < ApplicationController

  before_filter :set_user, only: [:show, :edit, :update]
  before_filter :require_user, only: [:show, :update]

  def new
    session[:affiliate_link_slug] = params[:affiliate_signup_code] if params[:affiliate_signup_code]
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
    if session[:affiliate_link_slug]
      @affiliate_link = AffiliateLink.find_by(slug: session[:affiliate_link_slug] )
      @user.affiliate_link_id = @affiliate_link.id
    end
    if @user.save
      flash[:success] = "您已成功註冊。您現在已經登錄。"
      # flash[:success] = "You have successfully registered. You are now logged in."
      session[:user_id] = @user.id
      AppMailer.send_welcome_email(@user).deliver
      redirect_to blog_path
      # redirect_to upgrade_path  #Uncomment with payment becomes available

    else
      flash.now[:error] = "您的帳戶未創建。"
      # flash.now[:error] = "Your account was not created."
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "個人資料保存成功。"
      # flash[:success] = "Profile saved successfully."
      redirect_to edit_user_path(@user)
    else
      flash.now[:danger] = "有一個錯誤，沒有任何保存。"
      # flash.now[:danger] = "There was an error and nothing was saved."
      render :edit
    end

  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :picture_url, :bio)
  end

end