module Partners::Multicenters
class PaymentsController < ApplicationController 
layout 'partnerdashboard'
before_filter :partner_authenticated?

  def index
  end

  def show
  	@bookings = Center.unscoped.find(params[:id]).bookings
  	@centers = Center.unscoped.where('partner_id=?', current_user.partner.id)
  end
  
end
end