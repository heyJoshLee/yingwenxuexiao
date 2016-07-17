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
      flash[:success] = "email_signup was saved"
      render :confirm
    else
      session[:return_to] ||= request.referer
      flash[:danger] = "There was a problem and your were not signed up. Please try again."
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