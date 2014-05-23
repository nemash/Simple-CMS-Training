class AdminUsersController < ApplicationController

  # Set the look and feel of the page
  layout "admin"

  # User must be logged in in order to view/use this page
  before_action :confirm_logged_in

  def index
    # Instantiate the object in order
    @admin_users = AdminUser.sorted
  end

  def new
    # Instantiate a new record
    @admin_user = AdminUser.new
  end

  def create
    # Instantiate the object using form parameters
    @admin_user = AdminUser.new(admin_user_params)
    # Save the object
    if @admin_user.save
      # If save succeeds, redirects to the index action
      flash[:notice] = "Admin user created successfully!"
      redirect_to(:action => 'index')
    else
      # If save fails, redisplay to the 'new' form so user can fix
      render('new')
    end
  end

  def edit
    # Find the object to edit using form parameters
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    # Find an existing object using form parameters
    @admin_user = AdminUser.find(params[:id])
    # If update success, redirect to the index actio
    if @admin_user.update_attributes(admin_user_params)
      flash[:notice] = 'User was Updated Sucssesfully'
      redirect_to(:action => 'index', :id => @admin_user.id)
    # If update fails, redisplay so user can fix
    else
      render('edit')
    end
  end

  def delete
    # Find the object using form parameters
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    # Find the object using form parameters and destroy it
    admin_user = AdminUser.find(params[:id])
    # Redirect to the index action after destroying the object
    flash[:notice] = "User '#{admin_user.name}' destroyed successfully!"
    redirect_to(:action => 'index')
  end

  private

  def admin_user_params
    params.require(:admin_user).permit(:first_name, :last_name, :email, :username, :password)
  end

end
