module Partners::Multicenters
class PaymentsController < ApplicationController 
layout 'partnerdashboard'
before_filter :partner_authenticated?

  def index
  end

  def show
  	@bookings = Center.unscoped.find(params[:id]).bookings
  	@centers = current_user.partner.centers.unscoped
  end
  
end
end