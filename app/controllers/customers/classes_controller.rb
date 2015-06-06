module Customers
class ClassesController < ApplicationController 
layout 'customerdashboard'
  def index
  	@passport = passport
  	@total = passport.try(:remaining_tickets) || 0 
    @active = passport.try(:total_active_clasbkings) || 0
  	@bookings = @passport.clasbkings.includes(:fpclass) unless @passport.nil?
  	@history = Clasbking.unscoped.where('customer_id=?', current_user.id).where('expired_at < ?', Time.now)
  end

  def show
  	@passport = passport
  end
end
end
