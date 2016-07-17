class Admin::EmailSignupsController < ApplicationController
  
 def index
   @email_signups = EmailSignup.all
 end

end