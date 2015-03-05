class SessionsController < ApplicationController
skip_before_filter :authenticate!
layout 'homepage'
  def partner
  end

  def customer
	 binding.pry
  end

  def customer_auth
    authenticate!
    render :text => 'authenticated'
  end

  def customer_logout
    warden.logout
  end

  private
  	def customer_params

  	end
end
