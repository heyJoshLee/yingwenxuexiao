class Admin::EmailSignupsController < AdminController
  
 def index
   @email_signups = EmailSignup.all
 end

 def destroy
  @email_id = params[:id]
  email_signup = EmailSignup.find(@email_id)
  email_signup.delete
  respond_to do |format|
    format.js
  end
 end

end