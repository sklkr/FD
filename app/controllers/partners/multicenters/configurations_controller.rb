module Partners::Multicenters
class ConfigurationsController < MulticentersController 
layout 'partnerdashboard'
before_filter :partner_authenticated?
before_filter :is_permitted?, :only => [:update, :show]
  def index
  	@centers = current_user.partner.centers.unscoped.includes(:city, :area)
  end
  
  def new
  	@center = Center.new
  end

  def show
  end

  def update
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
    def is_permitted?
      @center = Center.unscoped.find(params[:id])
      redirect_to root_url unless current_user.partner.id == @center.partner_id
    end
end
end