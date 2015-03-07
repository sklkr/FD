module Partners
class CentersController < ApplicationController 
skip_before_filter :authenticate!
before_filter :partner_authenticated?
layout 'partnerdashboard'
  def account_details

  end
  def details_create
  	ac = Accountinfo.new(details_params)
    ac.brand_id = Brand.find_or_create_by(name: params[:user][:brand])
    binding.pry
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
    binding.pry
    center = Centerinfo.new(center_params)
    if center.save
      flash[:notice] = 'Details updated'
      binding.pry
      redirect_to partner_centerinfos_path
    else
      render :text => 'something went wrong'
    end
  end

  def service_setup

  end

  def create_service 
    service = Service.new(service_params)
    if service.save
      binding.pry
      flash[:notice] = 'Details updated'
      redirect_to action: 'service_setup'
    else
      render :text => 'something went wrong'
    end
  end

  def instructors
    
  end
  def create_instructor
    instructor = Instructor.new(instructor_params)
    if instructor.save
      flash[:notice] = 'Instructor added'
      redirect_to action: 'instructors'
    else
      render :text => 'something went wrong'
    end
  end

  def pass
  end
  def coupon
  end

  private
  	def details_params
  		params.require(:user).permit("centername","personname","email","mobile","landline","address_1","address_2","landmark","city","pin","pan","tan","tin","taxregno","acno","bank_name","ifsc_code","bank_address", "bank_city")
  	end
    def center_params
      params.require(:center).permit(:name, :website, :centertype_id, :slots, :brief_desc, :detailed_desc, :latitude, :longitude)
    end
    def tags_allow
      params.require(:center).permit(:experience)
    end
    def service_params
      params.require(:user).permit(:type, :category_id, :name, :validity, :time_taken, :original_price, :selling_price, :gender_id, :schedule, :service_desc, :expired_on, :start_date, :end_date, :seats)
    end
    def instructor_params
      params.require(:instructor).permit(:name, :gender, :mobile, :email, :expertise, :description)
    end
end
end