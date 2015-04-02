module Customers
class MypassController < ApplicationController 
layout 'customerdashboard'
  def index
  	@mypass = Booking.where('customer_id=?', current_user.customer.id).where('service_type=?', 2).includes(:service)
  end
end
end