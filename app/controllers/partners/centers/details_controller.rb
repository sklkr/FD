module Partners::Centers
class DetailsController < ApplicationController 
skip_before_filter :authenticate!
before_filter :partner_authenticated?
layout 'partnerdashboard'
  
  def index
    @details = center.centerinfo || Centerinfo.new
    if center.centerinfo.nil?
     render :new
    else
     params[:id] = @details.id
     render :show
    end
  end

  def new
  end

  def create
    @centerinfo = Centerinfo.new(permit_params)
    params['category'].keys.each do |cat_id|
      center.categories << Category.find(cat_id)
    end
    @centerinfo.hour_id = Hour.create(params.permit['hours']).id
    @centerinfo.center_id = center.id
    if @centerinfo.save
      flash[:notice] = 'Details updated'
      redirect_to partners_center_photos_path(center.friendly_id)
    else
      render :text => 'something went wrong'
    end
  end


  def show

  end
  def update
  end

  private
    def permit_params
      params.require(:centerinfo).permit(:name, :website, :brand_photo, :centertype_id, :slots, :brief_desc, :detailed_desc, :latitude, :longitude)
    end
    def tags_allow
      params.require(:center).permit(:experience)
    end
    def center
      Center.friendly.find(params['center_id'])
    end
end
end