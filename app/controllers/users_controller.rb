class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => :show
  MINIMUM_PASSWORD_LENGTH = 8
  
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, :notice => "User created."
    else
      redirect_to users_path, :alert => "Unable to create user."
    end
    
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
      @user.errors.full_messages.each do |message|
        logger.info message
      end
    end
  end

  def destroy
    user = User.find(params[:id])
    user.archive
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :customer_id, :phone, :timezone, :role, :attachment)
  end

end
