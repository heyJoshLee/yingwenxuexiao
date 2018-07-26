class UsersController < ApplicationController

  before_filter :set_user, only: [:show, :edit, :update]
  before_filter :require_user, only: [:show, :update]

  def new
    session[:affiliate_link_code] = params[:affiliate_signup_code] if params[:affiliate_signup_code]
    # @affiliate_link = AffiliateLink.find_by(code: session[:affiliate_link_code]) if session[:affiliate_link_code]
    link = AffiliateLink.where("code ILIKE ?", session[:affiliate_link_code]).first if session[:affiliate_link_code]
    @affiliate_link = link if link && link.active?
    set_sign_up_video
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
    if session[:affiliate_link_code]
      # @affiliate_link = AffiliateLink.find_by(code: session[:affiliate_link_code] )
      link = AffiliateLink.where("code ILIKE ?", session[:affiliate_link_code]).first if session[:affiliate_link_code]
      @affiliate_link = link if link && link.active?
      @user.affiliate_link_id = @affiliate_link.id if @affiliate_link
    end
    if @user.save
      flash[:success] = "您已成功註冊。您現在已經登錄。"
      # flash[:success] = "You have successfully registered. You are now logged in."
      session[:user_id] = @user.id
      AppMailer.send_welcome_email(User.find(@user.id)).deliver_now
      # SendWelcomeEmailWorker.perform_async(@user.id) // comment out so I can downgrade worker plan on heroku. 
      # TODO: Add this back in once I get customers
      UserAction.create_user_action(@user.id, {action_type: "signed up"})
      redirect_to new_account_users_path

    else
      set_sign_up_video
      flash.now[:error] = "您的帳戶未創建。"
      # flash.now[:error] = "Your account was not created."
      render :new
    end
  end

  def new_account
    @video = Video.find_by(title: "How to take classes")
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


  def set_sign_up_video
    @video = Video.where(title: "Sign Up").first
  end

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :picture_url, :bio)
  end

end