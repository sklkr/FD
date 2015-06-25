class DetailsController < ApplicationController
layout 'homepage'
  
  def index
  	@center = Center.friendly.find(params[:center])
  	# @services = @center.services
  	@details = @center.centerinfo
  	@cphotos = @center.cphotos
  	# @hours = @details.hour
  	# @accountinfo = @center.accountinfo
  	@commontable = @center
  	commontator_thread_show(@commontable)
    @title = @center.name
  end
end
