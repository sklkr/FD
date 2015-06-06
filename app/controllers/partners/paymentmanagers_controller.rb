module Partners
class PaymentmanagersController < ApplicationController 
layout 'partnerdashboard'
before_filter :partner_authenticated?

  def summary
        
  end

  def commission
  
  end

  def transactions
  	@bookings = current_user.bookings
  end

  def partner_payment
	  	
  end
  

end
end