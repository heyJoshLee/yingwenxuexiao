class EmailSignupsController < ApplicationController
  
  def new
    @email_signup = EmailSignup.new
  end

  def confirm
  end

  def create
    @email_signup = EmailSignup.new(email_signup_params)
    if @email_signup.valid?
      @email_signup.page = params[:page]
      @email_signup.campaign = params[:campaign]
      @email_signup.save
      if params[:download_id]
        @download_link = DownloadLink.create(email: @email_signup.email, download_id: params[:download_id]) if params[:download_id]
        @download_link.send_email

        render :download_confirm
      else
        render :confirm
      end
    else
      session[:return_to] ||= request.referer
      flash[:danger] = "有一個問題，你沒有註冊。請再試一次。"
      # flash[:danger] = "There was a problem and your were not signed up. Please try again."
      redirect_to session.delete(:return_to)
    end
  end

  def edit
    @email_signup = EmailSignup.find_by(slug: params[:id])
  end

  private

  def email_signup_params
    params.require(:email_signup).permit!
  end

end