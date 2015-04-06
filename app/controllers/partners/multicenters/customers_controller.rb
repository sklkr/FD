module Partners::Multicenters
class CustomersController < ApplicationController 
layout 'partnerdashboard'
before_filter :partner_authenticated?

  def index
  end

  def show
  	@bookings = Center.unscoped.find(params[:id]).bookings.includes(:service, :customer).where.not(status: nil)	
  	@centers = current_user.partner.centers.unscoped
  end
  
end
end