class CustomersController < ApplicationController
layout 'homepage'

  def index

  end

  def edit
  	@user = User.find_by_remember_token(params[:id])
    @customer = @user.customer
  end

  def create
  	@customer = Customer.new(permit_params)
  	if @customer.save
      AdminMailer.customer_registration(@customer).delay.deliver
      respond_to do |format|
          format.js
      end
      #redirect_to page_path('verify')
  	else
      render :js => "alert('Email-Id already exists with FitnessPapa')"
  	end
  end


  def update
    @user = User.find_by_remember_token(params[:token])
    @customer = @user.customer
    if @customer.update_attributes(update_params)
      env['warden'].set_user(@user)
      redirect_to search_path, :notice => "Registration completed."
    else
      render :text => "something went wrong"
    end
  end

  private
  	def permit_params
  		params.require(:customer).permit(:email, :user_attributes => [:full_name, :phone, :password])
  	end

    def update_params
      params.require(:customer).permit(:user_attributes => [:full_name, :phone, :password])
    end
end
