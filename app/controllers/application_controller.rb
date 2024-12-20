class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def redirect_unless_admin
    redirect_to root_path if user_signed_in? && !current_user.admin?
  end

  def after_sign_in_path_for(resource)
    profile_path(current_user.nickname)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :nickname ])
  end
end
