class Admin::DashboardController < ApplicationController
  layout 'admin'  
  
  def index
    @extensions = Extension.all
    @users = User.all
  end

end
