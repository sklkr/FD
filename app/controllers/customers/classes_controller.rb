module Customers
class ClassesController < ApplicationController 
layout 'customerdashboard'
  def index
  	@passport = passport
  	@bookings = @passport.clasbkings.includes(:fpclass) unless @passport.nil?
  	@history = Clasbking.unscoped.where('customer_id=?', current_user.customer.id)
  end
end
end