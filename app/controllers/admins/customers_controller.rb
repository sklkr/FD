module Admins
class CustomersController < ApplicationController
	layout 'admin'
	before_action :admin_authenticated?
	def index
		@customers = Customer.all.includes(:user)
	end
	def show
		
	end

	def create
		# For FP Verification
		customers =  Customer.find(params['t1'].keys)
	
		unless params['send_email'].nil?
			customers.each do |c|
				AckMailer.atop(params['email_message'], c.email).deliver
			end
		end

		unless params['send_sms'].nil?
			return render :text => 'sms api needs to be integrated'
		end
		
		redirect_to admins_customers_path
	end
end
end