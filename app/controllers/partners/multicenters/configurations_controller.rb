module Partners::Multicenters
class ConfigurationsController < MulticentersController 
layout 'partnerdashboard'
before_filter :partner_authenticated?

  def index
  	@centers = current_user.partner.centers.includes(:city)
  end
  
  def new
  	@center = Center.new
  end

  def show
  	@center = Center.find(params[:id])
  end

  def update
  	@center = Center.find(params[:id])
  	if @center.update_attributes(:name => params[:center][:name])
  	 redirect_to partners_center_accounts_path(@center.friendly_id) 
  	else
  	 render :show
  	end
  end

  private
  	def permit_params
  		params.require(:center).permit(:name)
  	end
end
end