module Partners
class CentersController < ApplicationController 
layout 'partnerdashboard'
before_filter :partner_authenticated?
  def index
  	unless centers_list.blank?
  		redirect_to partners_center_accounts_path(centers_list.first.friendly_id)
  	else
      @center = Center.new
  		render :new
  	end
  end

  def new
    @center = Center.new
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
  		current_user.partner.centers
  	end
    def permit_params
      params.require(:center).permit(:name)
    end
end
end