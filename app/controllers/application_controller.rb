class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :set_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def set_current_user
    logger.info "SS__ CurrentUser: #{current_user.inspect} - #{current_user.nil?}"
    unless current_user.nil?
      User.current_user = current_user
      current_user.current_company = Company.find_by_id(cookies[:company_id]) if current_user.can_impersonate? && cookies[:company_id]
    end
  end
  
  def cookie_manager(actions = {})
    actions.each do |key,val|
      if key == :login
        cookies[:login] = { value: val.email, expires: 4.hours.from_now }
      elsif key == :impersonate
        cookies[:company_id] = { value: val }
      end
    end 
  end
  
  protected
  
  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user       = user_email && User.find_by_email(user_email)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    logger.info "LoggingIn: #{user_email} with #{params[:user_token]}\n#{user.inspect}"
    if user && Devise.secure_compare(user.auth_token, params[:user_token])
      sign_in user, store: false
    end
  end
  
  def authenticate_user!(opts = {})
    if user_signed_in?
      cookie_manager({login: current_user})
      super opts
    else
      redirect_to login_path, :notice => 'Please log in'
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar])
  end
end
