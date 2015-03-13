module Partners::Centers
class PhotosController < ApplicationController
  skip_before_filter :authenticate!
  before_filter :partner_authenticated?
  before_filter :partner_accessable?
  before_filter :is_more, :only => [:create]
  layout 'partnerdashboard'
  def index
    @cphotos = Cphoto.where('centerinfo_id=?',center.centerinfo.id)
    @center = center
  end  
  def show
  	render_wizard
  end

  def create
    center = Center.friendly.find(params[:center_id])
    cphoto = Cphoto.new(params.require('centerinfo').permit(:image))
    cphoto.centerinfo_id = center.centerinfo.id
    if cphoto.save
  		render :json => true
  	else
  		render :json => false
  	end
  end

  def update
    verification = Verification.new(params.require(:verification).permit(:pan, :tan, :tax, :address))
    verification.center_id = center.id
    if verification.save
      flash[:notice] = 'Verification is under progress. You will be notified after documents are verified'
      redirect_to partners_center_photos_path(center.friendly_id) 
    else
      render :text => "Something went wrong"
    end
  end

  def destroy
    #Need to improve sec later
    Cphoto.find(params[:id]).destroy
    redirect_to partners_center_photos_path(center.friendly_id)
  end
  private
    def is_more
      redirect_to partners_center_photos_path(center.friendly_id) if Cphoto.where('centerinfo_id=?',center.centerinfo.id).count > 6
    end
end
end