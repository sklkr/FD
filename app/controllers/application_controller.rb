class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  prepend_before_filter :authenticate!

   helper_method :warden, :signed_in?, :current_user

   def signed_in?
     !current_user.nil?
   end

   def current_user
     warden.user || warden.user(:partner)
   end

   def warden
     request.env['warden']
   end

   def authenticate!
     warden.authenticate!
   end

   def partner_authenticated?
      redirect_to sessions_partner_path unless warden.authenticated?(:partner)
   end

   private
    def partner_id
      warden.user(:partner).id unless warden.user(:partner).nil?
    end
end
