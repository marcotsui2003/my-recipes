class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_root_path
  end

  protected
  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
  end

  
end
