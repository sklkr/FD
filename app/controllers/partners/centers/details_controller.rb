module Partners::Centers
class DetailsController < ApplicationController 
skip_before_filter :authenticate!
before_filter :partner_authenticated?
before_filter :partner_accessable?
layout 'partnerdashboard'
  
  def index
    @details = center.centerinfo || Centerinfo.new
    if center.centerinfo.nil?
     @details.build_hour
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
    @centerinfo.hour_id = Hour.create(hour_params).id || nil
    # Has and belongs to many categories managed below
    center.category_ids = params.require(:centerinfo).permit(:category_ids => [])['category_ids']
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
    @centerinfo = Centerinfo.find(params[:id])
    center.category_ids = params.require(:centerinfo).permit(:category_ids => [])['category_ids']
    if @centerinfo.update_attributes(permit_params) && @centerinfo.hour.update_attributes(hour_params)
      flash[:notice] = 'Updated'
      render :show
    else
      render :text => 'something went wrong'
    end
  end

  private
    def permit_params
      params.require(:centerinfo).permit(:name, :website, :image, :centertype_id, :slots, :brief_desc, :detailed_desc, :latitude, :longitude)
    end
    def tags_allow
      params.require(:center).permit(:experience)
    end
    def hour_params
      params.require(:centerinfo).require(:hour_attributes).permit(:sun_from)
    end
end
end