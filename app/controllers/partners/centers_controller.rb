module Partners
class CentersController < ApplicationController
skip_before_filter :authenticate!
  def account_details

  end
  def details_create
  	Accountinfo.new(details_params)
  end
  def center_details
  end
  def service_setup
  end
  def instructors
  end
  def pass
  end
  def coupon
  end

  private
  	def details_params
  		params.require(:user).permit("centername","brand","personname","email","mobile","landline","address_1","address_2","landmark","city","pin"," pan"," tan"," tin","taxregno"," acno","bank_name","ifsc_code","bank_address")
  	end
end
