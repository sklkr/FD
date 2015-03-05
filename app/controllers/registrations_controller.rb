class RegistrationsController < ApplicationController
 skip_before_filter :authenticate!
 layout 'homepage'

  def partner
  end

  def customer
  	
  end

  def customer_signup
  	 cdata = Customer.new(customer_params)
  	 if cdata.save && details(cdata, user_params).save
  	 	redirect_to action: 'customer'
  	 	flash[:success] = 'Customer created'
	 else
	 	render :text => 'something went wrong'
	 end
  end

  def partner_signup

  end

  private
  	def customer_params
  		params.require(:user).permit(:email)
  	end

  	def user_params
  		params.require(:user).permit(:password, :first_name, :last_name)
  	end

  	def details(base, data)
  		user = User.new(data)
  		user.member_id = base.id
  		user
  	end
end
