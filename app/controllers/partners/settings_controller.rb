module Partners
class SettingsController < BaseController 
layout 'partners'
  
  def edit
    @info = current_partner.info || current_partner.build_info.save
    @info = current_partner.info
  end
  
  def create
   
  end

  def update
    @info = current_partner.info
    if @info.update(permit_params)
      redirect_to edit_partners_setting_path(@info.id)
    else
      render :edit
    end
  end

  def delete

  end

  private
    def permit_params
      params.require(:info).permit(:ac_no, :bank_name, :ifsc, :bank_address, :service_tax, :bank_location, :pan, :panproof, :idproof)
    end
end
end