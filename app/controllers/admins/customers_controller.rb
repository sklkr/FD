module Admins
class CustomersController < ApplicationController
	layout 'admin'
	def index
		@customers = Customer.all.includes(:user)
	end
	def show
		
	end
end
end