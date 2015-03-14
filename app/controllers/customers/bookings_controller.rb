module Customers
class BookingsController < ApplicationController 
layout 'customerdashboard'
  def index
  	@bookings = Booking.where('customer_id=?', current_user.id).includes(:service)
  end
end
end