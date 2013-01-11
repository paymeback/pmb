class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_admin_user!
	redirect_to admin_root_path unless current_user && current_user.has_role?(:admin)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
