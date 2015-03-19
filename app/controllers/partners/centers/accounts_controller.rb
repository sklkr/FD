module Partners::Centers
class AccountsController < ApplicationController 
before_filter :partner_authenticated?
before_filter :partner_accessable?
layout 'partnerdashboard'

  def index
    @account = center.accountinfo || Accountinfo.new
    @cities = cities
    if center.accountinfo.nil? 
     render :new
    else
     params[:id] = @account.id
     render :show
    end    
  end

  def new

  end
  def create
    @account = Accountinfo.new(permit_params)
    @account.center_id = center.id
    city = City.find_by_name(params[:accountinfo][:city])
    area = Area.find_by_name(params[:accountinfo][:area])
    center.update_attributes(:city_id => city.try(:id), :area_id => area.try(:id))
    if @account.save
      flash[:notice] = 'Details updated'
      redirect_to partners_center_account_path(center.friendly_id, @account.id)
    else
      render :new
    end
  end

  def show
    # If we fetch from center method below then it'll not update the record
    @account = Accountinfo.find(params[:id])
    @cities = cities
  end

  def update
    @account = Accountinfo.find(params[:id])
    city = City.find(params[:city_id]) if params[:city_id] != ''
    area = Area.find(params[:area_id]) if params[:area_id] != ''
    center.update_attributes(:city_id => city.try(:id), :area_id => area.try(:id))
    @cities = cities
    if @account.update_attributes(permit_params)
      flash[:notice] = 'Updated'
      render :show
    else
      render :text => "Something went wrong"
    end
  end

  private
  	def permit_params
  		params.require(:accountinfo).permit(:brandname,:personname,:email,:mobile,:landline,:address_1,:address_2,:landmark,:pin,:pan,:tan,:tin,:taxregno,:acno,:bank_name,:ifsc_code,:bank_address, :bank_city)
  	end

end
end