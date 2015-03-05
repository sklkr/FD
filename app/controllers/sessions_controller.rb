class SessionsController < ApplicationController
skip_before_filter :authenticate!
layout 'homepage'
  def partner
  end

  def customer
  	binding.pry
  end

  def customer_auth
 	binding.pry
  end

  private
  	def customer_params

  	end
end
