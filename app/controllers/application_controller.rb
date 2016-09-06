class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user, :practice_option_check, :require_paid_membership

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_paid_membership
    if !logged_in?
      redirect_to sign_in_path
    elsif !current_user.is_paid_member?
      redirect_to upgrade_path
    end
  end


  def require_user
    redirect_to sign_in_path unless current_user
  end

  def require_admin
    unless logged_in? && current_user.is_admin? || logged_in? && current_user.is_editor?
      flash[:danger] = "You do not have permission to do that"
      redirect_to root_path
    end
  end


end
