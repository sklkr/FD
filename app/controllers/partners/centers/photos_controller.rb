module Partners::Centers
class PhotosController < ApplicationController
  skip_before_filter :authenticate!
  before_filter :partner_authenticated?
  before_filter :partner_accessable?
  layout 'partnerdashboard'
  include Wicked::Wizard
  steps :centerphotos
  
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
end
end