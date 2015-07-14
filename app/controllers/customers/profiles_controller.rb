# Customers >> My Profile

module Customers
class ProfilesController < ApplicationController 
before_filter :authenticated?
layout 'customerdashboard'
before_filter { @c = current_user.user }

  def edit
  end

  def update
    if @c.update_attributes(permit_params)
      flash[:notice] = 'Details Updated'
      redirect_to edit_customers_profile_path('v1')
    else
      flash[:notice] = "Something went wrong"
      render 'edit'
    end
  end
  
  private
  	def permit_params
      params.require(:user).permit(:phone, :dob, :location, :address1, :address2, :emergency_name, :emergency_phone, :image)
  	end
end
end
