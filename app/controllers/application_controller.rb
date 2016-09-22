class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def after_sign_in_path_for(current_user)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      default_page = current_user.admin? ? root_path : search_path
      stored_location_for(current_user) || request.referer || default_page
    end
  end
end
