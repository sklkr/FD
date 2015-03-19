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
    redirect_to admin_root_path if warden.authenticate!(:superadmin, scope: :superadmin)
  end

  def checker
  end

  def partner_logout

  end
end
