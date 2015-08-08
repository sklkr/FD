## Admin Dashboard >> Orders 

module Fpadmin
class OrdersController < BaseController 
layout 'fpadmin'
before_filter :authenticated?

  def index
	@orders = Passport.unscoped.recent.includes(:customer).page params[:page] if params[:services].blank?
	@service_orders = OrderItem.services.includes(:order, :service) unless  params[:services].blank?
	@deal_orders = OrderItem.deals.includes(:order, :deal) unless  params[:deals].blank?
  end

  def show
  	
  end

  def destroy

  end
end
end