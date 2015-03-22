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
      redirect_to customers_detail_path('secure')
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
end
