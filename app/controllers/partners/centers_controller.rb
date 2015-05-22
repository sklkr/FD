module Partners
class CentersController < BaseController 
layout 'partners'

  def index
	 @centers = current_partner.centers
   @pending_centers = Center.unscoped.where('partner_id=?',current_partner.id)
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
    @center = ::Center.unscoped.friendly.find(params[:id])
    @center.build_accountinfo if @center.accountinfo.blank?
    @center.build_centerinfo if @center.centerinfo.blank?
  end

  def create
   @center = ::Center.new(permit_params)
   @center.partner_id = current_partner.id
   if @center.save
    redirect_to partners_centers_path
   else
    render :new
   end
  end

  def update
    @center = ::Center.friendly.find(params[:id])
    if @center.update(permit_params)
     redirect_to partners_centers_path
    else
     render :edit
    end
  end

  def delete

  end

  private
  	def centers_list
      Center.unscoped.where('partner_id=?', current_user.partner.id)
  	end
    def permit_params
      params.require(:center).permit(:center_type, :name, :place_name, :image, :facility_ids=>[], :experience_ids => [], :accountinfo_attributes => [:personname, :email, :mobile, :landline], :centerinfo_attributes => [:website, :detailed_desc, :latitude, :longitude, :address])
    end
end
end