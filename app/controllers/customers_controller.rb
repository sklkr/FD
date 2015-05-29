class CustomersController < ApplicationController
layout 'homepage'
  def index

  end

  def new
  	@customer = Customer.new
  	@customer.build_user
  end

  def create
  	@customer = Customer.new(permit_params)
  	if @customer.save
  		VerificationMailer.welcome_email(@customer.user, @customer).delay.deliver
  		flash[:success] = 'Email verification needed'
  		redirect_to page_path('verify')
  	else
  		render 'new'
  	end
  end

  private
  	def permit_params
  		params.require(:customer).permit(:email, :user_attributes => [:full_name, :phone, :password])
  	end
end
