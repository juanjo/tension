class ExtensionsController < ApplicationController
  before_filter :load_data, :only => [:new, :edit, :create, :update]  
  
  def index
    respond_to do |format|
      format.html { @extensions = Extension.paginate(:all, :page => params[:page], :order => 'updated_at DESC', :per_page => 3) }
      format.rss { @extensions = Extension.find(:all, :order => 'updated_at DESC', :limit => 10) }
    end
  end
  
  def my_extensions
    @extensions = current_user.extensions.paginate(:all, :page => params[:page], :order => 'updated_at DESC', :per_page => 3)
  end

  def show
    @extension = Extension.find(params[:id])
    begin
      @commits = GitHub::API.commits(@extension.username, @extension.repository).paginate(:page => params[:page], :order => 'committed_date DESC', :per_page => 5) if @extension.github?
    rescue OpenURI::HTTPError
      #@extension.update_attribute(:github, false)
      # Github down?
      @commits = nil
    end
  end

  def new
    @extension = current_user.extensions.new
  end

  def create
    @extension = current_user.extensions.new(params[:extension])

    respond_to do |format|
      if @extension.save
        flash[:notice] = "Spree Extension added succesfully."
        format.html { redirect_to extension_path(@extension)}
      else
        flash[:error] = "There're some problems adding this extension'."
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    begin
      @extension = current_user.has_role?(:site_admin) ? Extension.find(params[:id]) : current_user.extensions.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Extension not found as yours!" 
      redirect_to extensions_url
    end
  end
  
  def update
    @extension = current_user.has_role?(:site_admin) ? Extension.find(params[:id]) : current_user.extensions.find(params[:id])
    respond_to do |format|
      if @extension.update_attributes(params[:extension])
        flash[:notice] = "Spree Extension updated succesfully."
        format.html { redirect_to extension_path(@extension)}
      else
        flash[:error] = "There're some problems updating this extension'."
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @extension = current_user.has_role?(:site_admin) ? Extension.find(params[:id]) : current_user.extensions.find(params[:id])
    
    respond_to do |format|    
      if @extension.destroy
        flash[:notice] = "Spree Extension deleted succesfully."
        format.html { redirect_to extensions_url}        
      else
        flash[:error] = "There're some problems deleting this extension'."        
      end
    end
  end

  

  private
  def load_data
    @available_versions = Version.all
  end


end
