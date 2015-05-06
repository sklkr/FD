module Partners
class BaseController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :warden, :current_user, :current_partner

  def current_user
   warden.user(:partner)
  end

  def current_partner
    current_user && current_user.partner
  end

  def warden
    request.env['warden']
  end
end
end
