module Customers
class MypassController < ApplicationController 
layout 'customerdashboard'
  def index
  	@mypass = Booking.where('customer_id=?', current_user.customer.id).includes(:service).inject([]) {|v, booking| v << ( booking if([2,5].include?(*booking.service.category_id))); v }
  	@mypass.compact!
  end
end
end