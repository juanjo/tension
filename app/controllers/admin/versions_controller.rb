class Admin::VersionsController < ApplicationController
  layout 'admin'
  
  def index
    @versions = Version.find(:all, :order => 'name ASC')
  end

  def show
    @version = Version.find(params[:id])
    render 'versions/show'
  end

  def new
    @version = Version.new
  end

  def create
    @version = Version.new(params[:version])

    respond_to do |format|
      if @version.save
        flash[:notice] = "Spree Version added succesfully."
        format.html { redirect_to admin_versions_url}
      else
        flash[:error] = "There're some problems adding this version'."
        format.html { render :action => "new" }
      end
    end    
  end

  def edit
    @version = Version.find(params[:id])
  end

  def update
    @version = Version.find(params[:id])

    respond_to do |format|
      if @version.update_attributes(params[:version])
        flash[:notice] = "Spree Version updated succesfully."
        format.html { redirect_to admin_versions_url}
      else
        flash[:error] = "There're some problems updating this version'."
        format.html { render :action => "edit" }
      end
    end    
  end

  def destroy
    @version = Version.find(params[:id])
    @version.destroy
    
    flash[:notice] = "Spree Version removed succesfully."
    redirect_to admin_versions_url
  end

end
