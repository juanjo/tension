class VersionsController < ApplicationController  
  def show
    @version = Version.find(params[:id])
  end
end
