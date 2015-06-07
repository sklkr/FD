module Partners
class SettingsController < BaseController 
layout 'partners'
  
  def edit
    @info = current_user.info || current_user.build_info.save
    @info = current_user.info
  end
  
  def create
   if current_user.crypted_password && current_user.password == params['partner']['current_password'] && params['partner']['password'] == params['partner']['password_confirmation']
     current_user.password= params['partner']['password']
     flash[:notice] = "Password changed successfully"
     redirect_to change_password_partners_settings_path if current_user.save
   else
     flash["alert"] = "Please check your credentails once"
     @partner = current_user
     render 'change_password'
   end
  end

  def update
    @info = current_user.info
    if @info.update(permit_params)
      redirect_to edit_partners_settings_path(@info.id)
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
