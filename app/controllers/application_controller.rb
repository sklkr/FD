class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_for_lockup
  helper_method :warden, :signed_in?, :current_user, :is_partner?, :is_customer?

   def areas
     city = City.find(params[:city_id])
     respond_to do |format|
       format.json { render :json => city.areas }
     end
   end

   def signed_in?
     !current_user.nil?
   end

   def current_user
     warden.user || warden.user(:partner)
   end

   def is_partner?
    warden.authenticated?(:partner)
   end

   def is_customer?
    warden.authenticated?
   end

   def warden
     request.env['warden']
   end

   def authenticate!
     warden.authenticate!
   end

   # Admin auth checkers
   def authenticate_admin_user!
    redirect_to root_url unless warden.authenticated?(:superadmin)
   end

   def current_admin_user
      redirect_to root_url unless warden.authenticated?(:superadmin)
   end


   def customer_authenticated?
    redirect_to sessions_customer_path unless warden.authenticated?
   end

   def customer_accessable?
    # restrictions for customers
   end

   def partner_authenticated?
      redirect_to sessions_partner_path unless warden.authenticated?(:partner)
   end

   def partner_accessable?
    redirect_to root_url unless center.partner == current_user.partner
   end

   def center
    Center.friendly.find(params['center_id'])  rescue Center.find(params['id'])
   end

   def cities
    City.all
   end

   private
    def partner_id
      warden.user(:partner).partner.id unless warden.user(:partner).nil?
    end

    def searcher
      @cities = cities
      @c = Center.ransack(params[:q])
    end
end
