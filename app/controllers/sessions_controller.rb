class SessionsController < ApplicationController
skip_before_filter :authenticate!
layout 'homepage'
  def partner

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
    render :text => 'partner authenticated'
  end

  def partner_logout

  end
end
