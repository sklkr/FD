module Partners::Centers
class AccountsController < ApplicationController 
  before_filter :partner_authenticated?
  before_filter :partner_accessable?
  before_filter { params[:id] && @account = Accountinfo.find(params[:id])}

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
    brand = Brand.find_or_create_by(:name => params[:accountinfo][:brandname])
    @account = Accountinfo.new(permit_params)
    @account.center_id = center.id
    @account.brand_id = brand.id
    city = City.find(params[:city_id])
    area = Area.find(params[:area_id])
    center.update_attributes(:city_id => city.try(:id), :area_id => area.try(:id))
    if @account.save
      flash[:notice] = 'Details updated'
      redirect_to partners_center_account_path(center.friendly_id, @account.id)
    else
      render :new
    end
  end

  def edit
    if current_user.password == params['current_password'] && params['password'] == params['password_confirmation']
      current_user.password= params['password']
      flash['notice'] = 'Password changed successfully'
      redirect_to partners_center_accounts_path if current_user.save
    else
      flash["notice"] = "Please check your password provided"
      redirect_to partners_center_accounts_path
    end
  end

  def show
    # If we fetch from center method below then it'll not update the record
    @cities = cities
  end

  def update
    brand = Brand.find_or_create_by(:name => params[:accountinfo][:brandname])
    city = City.find(params[:city_id]) if params[:city_id] != ''
    area = Area.find(params[:area_id]) if params[:area_id] != ''
    center.update_attributes(:city_id => city.try(:id), :area_id => area.try(:id))
    @cities = cities
    unless @account.brand_id == brand.id
      @account.brand_id = brand.id
      @account.save
    end
    if @account.update_attributes(permit_params)
      flash[:notice] = 'Updated'
      render :show
    else
      render :text => "Something went wrong"
    end
  end

  private
  	def permit_params
  		params.require(:accountinfo).permit(:personname,:email,:mobile,:landline,:address_1,:address_2,:landmark,:pin,:pan,:tan,:tin,:taxregno,:acno,:bank_name,:ifsc_code,:bank_address, :bank_city)
  	end

end
end