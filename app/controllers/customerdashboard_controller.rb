class CustomerdashboardController < ApplicationController
  def details
    @customer = current_user
  end

  def details_update
    render :text => 'something went wrong' unless current_user.update_attributes(customer_params)
    redirect_to :action => 'details'
    flash[:notice] = 'updated'
  end

  def pass
  end

  def bookings
  end

  def transactions
  end

  def preferences
  end

  def referral
  end


  private
    def customer_params
      params.require(:user).permit(:first_name, :last_name)
    end
end
