class Admin::Dashboard::Reports::ReportsController < AdminController

  def index
    add_breadcrumb "Dashboard", admin_dashboard_path
  end

  def payments
    add_breadcrumb "Dashboard", admin_dashboard_path
    add_breadcrumb "Reports", admin_dashboard_reports_reports_path
    @start_date = params["start_date"]
    @end_date = params["end_date"]
    if params["filter"] == "true" && !@start_date.blank? && !@end_date.blank?
      @payments = Payment.where(created_at: @start_date..@end_date)
    else
      @payments = Payment.all
    end
  end

  def new_users
    add_breadcrumb "Dashboard", admin_dashboard_path
    add_breadcrumb "Reports", admin_dashboard_reports_reports_path
    @start_date = params["start_date"]
    @end_date = params["end_date"]
    if params["filter"] == "true" && !@start_date.blank? && !@end_date.blank?
      @users = User.where(created_at: @start_date..@end_date)
    else
      @users = User.all
    end    
  end

  def user_actions
    @user_actions = UserAction.all.reverse
  end

  def delete_user_action
    @action_id = params[:id]
    user_action = UserAction.find(@action_id)
    user_action.destroy
    respond_to do |format|
      format.js
    end
  end

end
