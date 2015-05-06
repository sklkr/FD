module Partners
class GalleriesController < BaseController
  before_filter :is_more, :only => [:create]

  layout 'partners'
  before_filter { @center = ::Center.friendly.find(params[:center_id]) }
  
  def index
   @photos = @center.cphotos
   @photo = Cphoto.new
  end

  def create
    @photo = Cphoto.new(params.require(:cphoto).permit(:image))
    @photo.center = @center
    if @photo.save
      redirect_to partners_center_galleries_path
    else
      render :json => false
    end
  end

  def destroy
    #Need to improve sec later
    Cphoto.find(params[:id]).destroy
    redirect_to partners_center_galleries_path(@center.friendly_id)
  end

  private
    def is_more
    end
end
end