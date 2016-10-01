class AdminController < ApplicationController
  before_action :require_admin
  add_breadcrumb "Admin", :root_path

end
