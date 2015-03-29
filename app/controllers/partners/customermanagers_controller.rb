module Partners
class CustomermanagersController < ApplicationController 
layout 'partnerdashboard'
before_filter :partner_authenticated?

  def index
    @bookings = current_user.partner.bookings
  end

  def show
  	@booking = Booking.find_by_token(params[:id])
  end

  def edit
  	@customer = Customer.find(params[:id])
  	@data = @customer.user
  end

end
end