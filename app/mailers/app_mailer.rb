class AppMailer < ActionMailer::Base

  layout "app_mailer"

  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: "hello@yingwenxuexiao.com", subject: "Welcome to Yingwenxuexiao.com"
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

  def stripe_charge(user, amount, currency)
    @user = user
    @amount = amount
    @currency = currency
    mail to: @user.email, from: "billing@yingwenxuexiao.com", subject: "英文學校 (Taiwan English School) Monthly charge"
  end

  def subscription_cancel(user)
    @user = user
    mail to: @user.email, from: "billing@yingwenxuexiao.com", subject: "英文學校 (Taiwan English School) Premium Account Canceled"
  end

  def admin_payment_notification(user, amount, currency)
    @user = user
    @amount = amount
    @currency = currency
    mail to: ENV["ADMIN_EMAIL"], from: "billing@yingwenxuexiao.com", subject: "#{currency} #{amount/100} paid from #{user.email}"
  end

  def notify_admin_of_subscription_cancel(user)
    @user = user
    mail to: ENV["ADMIN_EMAIL"], from: "billing@yingwenxuexiao.com", subject: "SUB Cancel #{user.email}"
  end

end