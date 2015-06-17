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
      # AdminMailer.customer_registration(@customer).delay.deliver
      RegistrationMailer.send_manual(@customer).deliver
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
    if @customer.update_attributes(update_params) && @customer.user.update!(:active => true, :location => @user.location)
      env['warden'].set_user(@customer.user)
      redirect_to search_path, :notice => "Registration completed."
    else
      render :text => "something went wrong"
    end
  end

  private
  	def permit_params
  		params.require(:customer).permit(:email, :user_attributes => [:location])
  	end

    def update_params
      params.require(:customer).permit(:user_attributes => [:full_name, :phone, :password])
    end
end
