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
    # reject will remove orders that does not contain service order items 
    @orders = current_user.success_orders.includes(:service_order_item).reject{|o| o.service_order_item.blank? }
    @deal_orders = current_user.success_orders.includes(:deal_order_item).reject{|o| o.deal_order_item.blank? }
  end

  def color 
    false
  end
end
end
