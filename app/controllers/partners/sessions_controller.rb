module Partners
  class SessionsController < BaseController
    skip_before_filter :authenticate!  
    before_filter :authenticated, only: [:new]
    layout 'application'

    def new
      @partner ||= Partner.new
      @partner.build_user
    end

    def create
      warden.authenticate!(:partner, scope: :partner)
      redirect_to partners_orders_path, notice: "Welcome to FitnessPapa" 
    end

    #def admin
      
    #end

    def destroy
      warden.logout(:partner)
      flash[:notice] = "You have logged out successfully"
      redirect_to partners_path
    end

    #def partner_auth
    #  warden.authenticate!(:partner, scope: :partner)
    #  redirect_to partners_centers_path
    #end

    #def admin_auth
     # redirect_to admins_customers_path if warden.authenticate!(:superadmin, scope: :superadmin)
    #end

    #def checker
    #end

    #def partner_logout

    #end
  
   private
      #def user_params
      #  params.require(:user).permit(:phone)
      #end
      #def customer_params
      #  params.require(:user).permit(:email)
      # end

      # For omniauth facebook auth new
      def params_builder
        list = {:email => auth_hash.info.email}
        user_attributes = {:first_name => auth_hash.info.first_name, :last_name => auth_hash.info.last_name}
        identity_attributes = {:provider => auth_hash.provider, :uid => auth_hash.uid}
        list.merge!({:user_attributes => user_attributes})
        list.merge!({:identity_attributes => identity_attributes})
      end
  end
end