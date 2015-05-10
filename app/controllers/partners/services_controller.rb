module Partners
class ServicesController < BaseController 
layout 'partners'
before_filter { @center = ::Center.friendly.find(params[:center_id]) }
  def index
	 @services = @center.services
  end

  def new
   @service = Service.new
  end

  def show
    
  end

  def edit

  end

  def create
   @service = Service.new(permit_params)
   @service.center = @center if( @center.partner == current_partner ) # to check if this center belongs to current partner
   if @service.save
    redirect_to partners_center_services_path
   else
    render 'new'
   end
  end

  def update

  end

  def delete

  end

  private
    def permit_params
      params.require(:service).permit(:name, :original_price, :selling_price, :service_desc, :schedule, :gender_id, :end_date)
    end
end
end