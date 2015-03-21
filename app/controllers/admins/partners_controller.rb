module Admins
class PartnersController < ApplicationController
	layout 'admin'
	def index
		@centers = Centerinfo.all.includes(:center)
	end

	def show

	end

	def create
		unless params['fp'].nil?
			centers = Centerinfo.find(params['t1'].keys)
			centers.each do |c|
				c.update_attributes(:fp_verified => true)
			end
			redirect_to admins_partners_path
		end
	end
end
end