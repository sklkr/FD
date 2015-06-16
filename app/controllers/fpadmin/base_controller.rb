module Fpadmin
class BaseController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :warden, :current_user


  def current_user
   warden.user(:superadmin)
  end

  def warden
    request.env['warden']
  end

  def authenticate!
    # redirect_to partners_path unless warden.authenticated?(:partner)
    # authenticate_or_request_with_http_basic do |username, password|
    #     username == "foo" && password == "bar"
    # end
  end

  def authenticated?
    redirect_to new_session_path if current_user.blank?
  end
end
end
