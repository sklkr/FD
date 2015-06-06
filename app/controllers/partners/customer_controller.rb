module Partners
class CustomerManagersController < ApplicationController 
layout 'partnerdashboard'
before_filter :partner_authenticated?

  def index
    @bookings = current_user.bookings
  end

  def show
  	
  end


end
end