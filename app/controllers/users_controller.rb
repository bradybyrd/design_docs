class UsersController < ApplicationController
  !before_action :authenticate_user!
  before_action :admin_only, :except => :show
  before_action :set_user, only: [:show, :edit, :update, :destroy, :impersonate]
  MINIMUM_PASSWORD_LENGTH = 8
  
  def index
    @users = User.all
  end

  def edit
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
    @user.archive
    redirect_to users_path, :notice => "User deleted."
  end

  def impersonate
    if user_params[:company_id]
      @user.current_company = Company.find_by_id(user_params[:company_id])
      cookie_manager({impersonate: @user.current_company.id })
    end
    redirect_to "/"
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end 

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :company_id, :phone, :timezone, :role, :avatar)
  end

end
