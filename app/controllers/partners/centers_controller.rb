module Partners
class CentersController < ApplicationController 
layout 'partners'

  def index
	 @centers = current_partner.partner.centers
   respond_to do |format|
    format.html
    format.xml { render xml: @centers.to_xml }
    format.json { render json: @centers.to_json }
   end
  end

  def new
    @center = ::Center.new
    @center.build_accountinfo
    @center.build_centerinfo
  end

  def show
    @center = ::Center.friendly.find(params[:id]) 
  end

  def edit

  end

  def create
   @center = ::Center.new(permit_params)
   @center.partner_id = current_partner.partner.id
   if @center.save
    redirect_to partners_centers_path
   else
    render :new
   end
  end

  def update

  end

  def delete

  end

  private
  	def centers_list
      Center.unscoped.where('partner_id=?', current_user.partner.id)
  	end
    def permit_params
      params.require(:center).permit(:center_type, :name, :place_name, :image, :facility_ids=>[], :experience_ids => [], :accountinfo_attributes => [:personname, :email, :mobile, :landline], :centerinfo_attributes => [:website, :detailed_desc, :latitude, :longitude])
    end
end
end