module Partners
class BaseController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :warden, :current_user, :current_partner
  before_filter :authenticate!

  def current_user
   warden.user(:partner)
  end

  def current_partner
    current_user && current_user.partner
  end

  def warden
    request.env['warden']
  end

  def authenticate!
    redirect_to partners_path unless warden.authenticated?(:partner)
  end

  def authenticated
    redirect_to partners_orders_path if warden.authenticated?(:partner)
  end
end
end
