module Partners
class CentersController < ApplicationController
skip_before_filter :authenticate!
  def account_details

  end
  def details_create
  	ac = Accountinfo.new(details_params)
    ac.brand_id = Brand.find_or_create_by(name: params[:user][:brand])
    if ac.save
      flash[:notice] = 'Details updated'
      redirect_to action: 'account_details'
    else
      render :text => 'something went wrong'
    end
  end
  def center_details

  end
  def create_center
    center = Centerinfo.new(center_params)
    if center.save
      flash[:notice] = 'Details updated'
      redirect_to action: 'center_details'
    else
      render :text => 'something went wrong'
    end
  end

  def service_setup
    
  end
  def create_service 

  end
  
  def instructors
  end
  def pass
  end
  def coupon
  end

  private
  	def details_params
  		params.require(:user).permit("centername","personname","email","mobile","landline","address_1","address_2","landmark","city","pin","pan","tan","tin","taxregno","acno","bank_name","ifsc_code","bank_address")
  	end
    def center_params
      params.require(:user).permit(:name, :website, :centertype_id, :slots, :brief_desc, :detailed_desc, :latitude, :longitude)
    end
end
end