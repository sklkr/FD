module Partners
class CentersController < ApplicationController 
layout 'partners'

  def index
	 @centers = current_partner.partner.centers
  end

  def new
    @center = ::Center.new
    @center.build_accountinfo
    @center.build_centerinfo
  end

  def create
   center = Center.new(permit_params)
   center.partner_id = partner_id
   if center.save
    redirect_to partners_center_accounts_path(center.friendly_id) 
   else
    render :new
   end
  end

  private
  	def centers_list
      Center.unscoped.where('partner_id=?', current_user.partner.id)
  	end
    def permit_params
      params.require(:center).permit(:name)
    end
end
end