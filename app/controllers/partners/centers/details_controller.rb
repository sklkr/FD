module Partners::Centers
class DetailsController < ApplicationController 
  skip_before_filter :authenticate!
  before_filter :partner_authenticated?
  before_filter :partner_accessable?
  before_filter { params[:id] && @details = Centerinfo.find(params[:id])}

  layout 'partnerdashboard'
  
  def index
    @details = center.reload.centerinfo || Centerinfo.new
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
    @centerinfo.category_ids = params.require(:centerinfo).permit(:category_ids => [])['category_ids']
    @centerinfo.experience_ids = params.require(:centerinfo).permit(:experience_ids => [])['experience_ids']
    @centerinfo.hour_id = Hour.create(hour_params).id || nil
    # Has and belongs to many categories managed below
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
    @details.category_ids = params.require(:centerinfo).permit(:category_ids => [])['category_ids']
    @details.experience_ids = params.require(:centerinfo).permit(:experience_ids => [])['experience_ids']
    if @details.update_attributes(permit_params) && @details.hour.update_attributes(hour_params)
      flash[:notice] = 'Updated'
      redirect_to partners_center_photos_path(center.friendly_id)
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
      params.require(:centerinfo).require(:hour_attributes).permit(:sun_from, :sun_to, :mon_from, :mon_to, :tue_from, :tue_to, :wed_from, :wed_to, :thu_from, :thu_to, :fri_from, :fri_to, :sat_from, :sat_to)
    end
end
end