module Customers
class BookingsController < ApplicationController 
layout 'customerdashboard'
  def index
  	@bookings = Booking.where('customer_id=?', current_user.customer.id).where('service_type=?', 1).includes(:service)
  end
end
end