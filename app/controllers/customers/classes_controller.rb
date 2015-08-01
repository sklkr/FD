# Customers >> My class

module Customers
class ClassesController < ApplicationController 
layout 'customerdashboard'
 
  # Customers >> My Class, History
  def index
  	@passport = passport
  	@total = passport.try(:remaining_tickets) || 0 
    @active = passport.try(:total_active_clasbkings) || 0
    @bookings = @passport.clasbkings.includes(:fpclass) unless @passport.nil?
  	@history = Clasbking.unscoped.where('customer_id=?', current_user.id).where('expired_at < ?', Time.now)
  end

  # Customers >> My Orders
  def show
  	@passport = passport
    @service_orders = current_user.orders.includes(:service_orders).reject{|o| o.service_orders.blank? }
  end

  def color 
    false
  end
end
end
