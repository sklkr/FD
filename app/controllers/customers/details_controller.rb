module Customers
class DetailsController < ApplicationController 
before_filter :customer_authenticated?
layout 'customerdashboard'

  def index
    # If we fetch from center method below then it'll not update the record
    @details = current_user
    @email = @details.customer.email
    @cities = cities
  end

  def create
    @details = current_user
    if @details.update_attributes(permit_params)
      flash[:notice] = 'Updated'
      render :index
    else
      render :text => "Something went wrong"
    end
  end

  private
  	def permit_params
  		params.require(:user).permit("first_name","centertype_id","address1","address2","area_id","city_id","image","phone","emergency_phone")
  	end
end
end
