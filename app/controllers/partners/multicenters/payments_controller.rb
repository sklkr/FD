module Partners::Multicenters
class PaymentsController < ApplicationController 
layout 'partnerdashboard'
before_filter :partner_authenticated?

  def index
  end

  def show
  	@bookings = Center.find(params[:id]).bookings
  	@centers = current_user.partner.centers
  end
  
end
end