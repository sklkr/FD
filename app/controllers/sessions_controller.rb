class SessionsController < ApplicationController
skip_before_filter :authenticate!
layout 'homepage'
  def partner
    if warden.authenticated?(:partner)
      redirect_to partners_centers_path
    end
  end

  def customer
  end

  def customer_auth
    authenticate!
    unless params[:url].nil?
      @booking = Booking.find_by_token(params[:url])
      @booking.customer_id = current_user.customer.id 
      if @booking.save
        redirect_to add_details_path('center', 'service', :token => @booking.token)
      end
    else
      redirect_to customers_details_path
    end
        
  end

  def admin
    
  end

  def customer_logout
    warden.logout
    redirect_to root_url
  end

  def partner_auth
    warden.authenticate!(:partner, scope: :partner)
    redirect_to partners_centers_path
  end

  def admin_auth
    redirect_to admins_customers_path if warden.authenticate!(:superadmin, scope: :superadmin)
  end

  def checker
  end

  def partner_logout

  end

  def guest_creator
    user = User.new(user_params)
    user.password = params['user']['phone']
    user.first_name = 'guest'
    user.last_name = 'guest'
    user.active = true
     if user.save
      cdata = Customer.new(customer_params)
      cdata.user_id = user.id
       if cdata.save
        @booking = Booking.find_by_token(params[:url])
        @booking.customer_id = cdata.id
        @booking.save
        env['warden'].set_user(user)
        VerificationMailer.guest_email(cdata).deliver
        redirect_to add_details_path('center', 'service', :token => @booking.token)
       else
        render :text => 'something went wrong'
       end
     else
      render :text => 'something went wrong'
     end
  end


  # Oauth authentications
  def facebook
    user = User.find_or_create_by(:uid => auth_hash['uid'])
    customer = Customer.find_or_create_by(:email => auth_hash['info']['email'], :user_id => user.id)
    warden.set_user(user)
    redirect_to customers_details_path
  end

  protected

    def auth_hash
      request.env['omniauth.auth']
    end

    def user_params
      params.require(:user).permit(:phone)
    end
    def customer_params
      params.require(:user).permit(:email)
    end
end
