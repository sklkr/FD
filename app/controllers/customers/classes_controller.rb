module Customers
class ClassesController < ApplicationController 
layout 'customerdashboard'
  def index
  	@passport = passport
  	@bookings = @passport.clasbkings.includes(:fpclass)
  end
end
end