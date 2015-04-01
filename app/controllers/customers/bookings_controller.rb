module Customers
class BookingsController < ApplicationController 
layout 'customerdashboard'
  def index
  	@bookings = Booking.where('customer_id=?', current_user.customer.id).includes(:service).inject([]) {|v, booking| v << ( booking unless([2,5].include?(*booking.service.category_id))); v }
  	@bookings.compact!
  end
end
end