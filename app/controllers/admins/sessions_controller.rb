module Admins
class SessionsController < ApplicationController
	layout 'admin'
	before_filter :is_admin, only: [:show]

	def show
	end

	def create
	    redirect_to '/admins/sessions' if warden.authenticate!(:superadmin, scope: :superadmin)
	end
	private
		def is_admin
			redirect_to admins_customers_path if warden.authenticated?(:superadmin)
		end
end
end