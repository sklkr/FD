module Fpadmin
class SessionsController < BaseController
   # skip_before_filter :authenticate!  
   # before_filter :authenticated, only: [:new]
   layout 'application'
   before_filter :check_session, except: :destroy

   def new
     @admin ||= Superadmin.new
     @admin.build_user
   end

   def create
     if warden.authenticate!(:superadmin, scope: :superadmin)
       redirect_to customers_path
     else
       render :text => 'something went wrong'
     end
   end

   def destroy
     warden.logout(:superadmin)
     flash[:notice] = "Why did you signout ? Come back as soon as you can"
     redirect_to action: 'new'
   end

   private
    def check_session
      redirect_to customers_path unless current_user.blank?
    end
end
end
