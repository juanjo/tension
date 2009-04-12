class Admin::DashboardController < ApplicationController
  before_filter :login_required
  require_role :site_admin
  
  layout 'admin'  
  
  def index
    @extensions = Extension.all
    @users = User.all
  end

end
