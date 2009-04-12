class Admin::UsersController < ApplicationController
  before_filter :login_required  
  require_role :site_admin  

  before_filter :find_user, :only => [:show, :edit, :update, :suspend, :unsuspend, :destroy, :purge, :activate, :reset_password]
  
  layout 'admin'  
    
  def index
    @users = User.paginate(:all, :page => params[:page], :order => 'login DESC', :per_page => 10)
  end

  def show
    render 'users/show'
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def create
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      flash[:notice] = "User created successfully."
      redirect_to admin_user_path(@user)
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end


  def edit
    @roles = Role.all
  end
  
  
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "User updated succesfully."
        format.html { redirect_to admin_user_path(@user)}
      else
        flash[:error] = "There're some problems updating this extension'."
        format.html { render :action => "edit" }
      end
    end
  end  

  def activate
    @user.activate!
    redirect_to admin_users_path
  end


  def suspend
    @user.suspend!
    redirect_to admin_users_path
  end

  def unsuspend
    @user.unsuspend!
    redirect_to admin_users_path
  end

  def destroy
    @user.delete!
    redirect_to admin_users_path
  end

  def purge
    @user.destroy
    redirect_to admin_users_path
  end


  protected
    def find_user
      @user = User.find(params[:id])
    end


end
