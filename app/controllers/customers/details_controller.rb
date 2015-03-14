module Customers
class DetailsController < ApplicationController 
before_filter :customer_authenticated?
layout 'customerdashboard'

  def show
    # If we fetch from center method below then it'll not update the record
    @details = current_user
    @email = @details.customer.email
  end

  def update
    @details = current_user
    if @details.update_attributes(permit_params)
      flash[:notice] = 'Updated'
      render :show
    else
      render :text => "Something went wrong"
    end
  end

  private
  	def permit_params
  		params.require(:user).permit("first_name","centertype_id","address1","address2","area","city","image","phone","emergency_phone")
  	end

end
end
