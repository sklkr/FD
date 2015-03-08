module Partners::Centers
class DetailsController < ApplicationController 
skip_before_filter :authenticate!
before_filter :partner_authenticated?
layout 'partnerdashboard'
  
  def index

  end

  def new
    binding.pry
  end
  def create
    center = Centerinfo.new(permit_params)
    if center.save
      flash[:notice] = 'Details updated'
      redirect_to partner_centerinfos_path
    else
      render :text => 'something went wrong'
    end
  end

  private
    def permit_params
      params.require(:center).permit(:name, :website, :centertype_id, :slots, :brief_desc, :detailed_desc, :latitude, :longitude)
    end
    def tags_allow
      params.require(:center).permit(:experience)
    end
end
end