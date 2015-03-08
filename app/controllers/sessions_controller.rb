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
    render :text => 'authenticated'
  end

  def customer_logout
    warden.logout
  end

  def partner_auth
    warden.authenticate!(:partner, scope: :partner)
    redirect_to partners_centers_path
  end

  def partner_logout

  end
end
