module Customers
class DetailsController < ApplicationController 
before_filter :customer_authenticated?
layout 'customerdashboard'
before_filter { @details = current_user }

  def index
    # If we fetch from center method below then it'll not update the record
    @email = @details.customer.email
    @cities = cities
  end

  def create
    if @details.update_attributes(permit_params)
      flash[:notice] = 'Updated'
      redirect_to customers_details_path
    else
      render :text => "Something went wrong"
    end
  end

  private
  	def permit_params
  		params.require(:user).permit("first_name","centertype_id","address1","address2","area_id","city_id","image","phone","emergency_phone", "emergency_name")
  	end
end
end
