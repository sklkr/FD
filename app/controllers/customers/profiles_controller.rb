module Customers
class ProfilesController < ApplicationController 
before_filter :authenticated?
layout 'customerdashboard'
before_filter { @c = current_user }

  def edit
  end

  def update
    binding.pry
    if @customer.update_attributes(permit_params)
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
