## Base Controller for all frontend view

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :warden, :signed_in?, :current_user, :is_partner?, :is_customer?, :center, :current_order, :current_service_order, :which_user, :color
  before_filter { @customer ||= Customer.new; @customer.build_user }
  # Referral checker
  before_filter :ref_to_cookie

   def areas
     city = City.find(params[:city_id])
     respond_to do |format|
       format.json { render :json => city.areas }
     end
   end

   def signed_in?
     !current_user.nil?
   end

   def color
    true
   end

   def passport
    current_user.passport
   end

   def current_user
    warden.user.customer if warden.user
   end

   def which_user
    current_user || Guest.new
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
    Order.find(session[:order_id]) unless session[:order_id].nil?
   end

   # Return order that is in pending state using session : service_id
   def current_service_order
    Order.find(session[:service_id]) unless (session[:service_id].nil? || (Order.find(session[:service_id]).status == 'success'))
   end

   private
    def ref_to_cookie
      if params[:ref] && !Rails.application.config.ended
          unless Customer.find_by_referral_code(params[:ref]).nil?
            cookies[:h_ref] = { :value => params[:ref], :expires => 1.week.from_now }
          end

          if request.env["HTTP_USER_AGENT"] and !request.env["HTTP_USER_AGENT"].include?("facebookexternalhit/1.1")
              redirect_to proc { url_for(params.except(:ref)) }  
          end
      end
    end
end
