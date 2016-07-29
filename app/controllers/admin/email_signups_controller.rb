class Admin::EmailSignupsController < AdminController
  
 def index
   @email_signups = EmailSignup.all
 end

end