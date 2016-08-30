class AppMailer < ActionMailer::Base

  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: "hello@yingwenxuexiao.com", subject: "Welcome to Myflix"
  end

  def send_download_link(download_link)
    @download_link = download_link
    @download = @download_link.download
    mail to: @download_link.email, from: "downloads@yingwenxuexiao.com", subject: "Your download from Yingwenxuexiao.com"
  end

  def send_forgot_password(user)
    @user = user
    mail to: @user.email, from: "forgot_password@yingwenxuexiao.com", subject: "Forgot Email"
  end

end