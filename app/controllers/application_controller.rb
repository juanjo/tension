# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  include AuthenticatedSystem
  include RoleRequirementSystem
  include EasyRoleRequirementSystem
  
  before_filter :set_active_tab

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation

  def tag_cloud
    @tags = Extension.tag_counts
  end

    
  protected
    def set_active_tab
      # will default to controller_name if @active_tab
      # has not been set by another controller
      @active_tab ||= self.controller_name.to_sym
    end
  
end
