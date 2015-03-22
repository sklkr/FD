module Admins
class CustomersController < ApplicationController
	layout 'admin'
	before_action :admin_authenticated?
	def index
		@customers = Customer.all.includes(:user)
	end
	def show
		
	end
end
end