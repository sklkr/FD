module Partners::Centers
class AccountsController < ApplicationController 
skip_before_filter :authenticate!
before_filter :partner_authenticated?
layout 'partnerdashboard'

  def index
    @account = center.accountinfo || Accountinfo.new
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
  end

  def update
    @account = Accountinfo.find(params[:id])
    if @account.update_attributes(permit_params)
      binding.pry
      flash[:notice] = 'Updated'
      render :show
    else
      render :text => "Something went wrong"
    end
  end

  private
  	def permit_params
  		params.require(:accountinfo).permit(:brandname,:centername,:personname,:email,:mobile,:landline,:address_1,:address_2,:landmark,:city,:pin,:pan,:tan,:tin,:taxregno,:acno,:bank_name,:ifsc_code,:bank_address, :bank_city)
  	end

    def center
      Center.friendly.find(params['center_id'])
    end
end
end