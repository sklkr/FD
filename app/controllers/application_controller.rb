class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :warden, :signed_in?, :current_user, :is_partner?, :is_customer?, :center, :current_order
  before_filter { @customer ||= Customer.new; @customer.build_user }

   def areas
     city = City.find(params[:city_id])
     respond_to do |format|
       format.json { render :json => city.areas }
     end
   end

   def signed_in?
     !current_user.nil?
   end

   def passport
    current_user.customer.passport
   end

   def current_user
     warden.user
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


   def authenticated?
    redirect_to new_session_path unless warden.authenticated?
   end

   def customer_accessable?
    # restrictions for customers
   end

   def admin_authenticated?
      redirect_to '/admins/sessions' unless warden.authenticated?(:superadmin)
   end

   
   def center
      Center.unscoped.friendly.find(params['center_id'])  rescue Center.unscoped.friendly.find(params['id'])
   end

   def should_authenticate
    redirect_to new_session_path(:url => '/checkout'), :notice => "Authentication Required" unless current_user
   end

   # for omniauth
   def auth_hash
     request.env['omniauth.auth']
   end

   def current_order
    Order.find(session[:order_id])  unless session[:order_id].nil?
   end
end
