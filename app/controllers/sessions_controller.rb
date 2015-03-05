class SessionsController < ApplicationController
skip_before_filter :authenticate!
layout 'homepage'
  def partner
  end

  def customer
  	binding.pry
  end

  def customer_auth
 	redirect_to sessions_customer_path, :notice => 'Authentication failed' if warden.authenticate.nil?
  end

  private
  	def customer_params

  	end
end
