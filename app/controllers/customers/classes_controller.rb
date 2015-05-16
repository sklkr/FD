module Customers
class ClassesController < ApplicationController 
layout 'customerdashboard'
  def index
  	@passport = passport
  	@bookings = @passport.clasbkings.includes(:fpclass) unless @passport.nil?
  end
end
end