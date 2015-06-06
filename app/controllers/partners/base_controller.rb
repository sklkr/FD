module Partners
class BaseController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :warden, :current_user
  before_filter :authenticate!

  def current_user
   warden.user(:partner).partner if warden.user(:partner)
  end

  def warden
    request.env['warden']
  end

  def authenticate!
    redirect_to partners_path unless warden.authenticated?(:partner)
  end

  def authenticated
    redirect_to partners_classes_path if warden.authenticated?(:partner)
  end
end
end
