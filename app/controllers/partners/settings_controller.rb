module Partners
class SettingsController < BaseController 
layout 'partners'
  
  def edit
    @info = current_partner.info || current_partner.build_info.save
    @info = current_partner.info
  end
  
  def create
   if current_user.crypted_password && current_user.password == params['user']['current_password'] && params['user']['password'] == params['user']['password_confirmation']
     current_user.password= params['user']['password']
     flash[:notice] = "Password changed successfully"
     redirect_to change_password_partners_settings_path if current_user.save
   else
     flash["alert"] = "Please check your credentails once"
     @user = current_user
     render 'change_password'
   end
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

  def change_password
    @user = current_user
  end

  private
    def permit_params
      params.require(:info).permit(:ac_no, :bank_name, :ifsc, :bank_address, :service_tax, :bank_location, :pan, :panproof, :idproof)
    end
end
end