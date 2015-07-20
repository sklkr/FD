# All partner activities super class

module Partners
class BaseController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :warden, :current_user
  before_filter :authenticate!

  # Maintains current logged in Model <Partner email='...' >
  # returns => nil , if no session exists
  def current_user
   warden.user(:partner).partner if warden.user(:partner)
  end

  # Holds warden environment data, refer warden gem for more info
  def warden
    request.env['warden']
  end

  # partner session checker 
  # Redirects to partner signin if partner session does not exist
  def authenticate!
    redirect_to partners_path unless warden.authenticated?(:partner)
  end

  # redirection after partner authenticated to partner classes index page
  def authenticated
    redirect_to partners_classes_path if warden.authenticated?(:partner)
  end
end
end
