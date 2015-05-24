module Customers
class ClassesController < ApplicationController 
layout 'customerdashboard'
  def index
  	@passport = passport
  	@total = passport.try(:remaining_tickets) || 0 
  	@bookings = @passport.clasbkings.includes(:fpclass) unless @passport.nil?
  	@history = Clasbking.unscoped.where('customer_id=?', current_user.customer.id)
  end
end
end