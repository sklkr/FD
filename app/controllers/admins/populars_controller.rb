module Admins
class PopularsController < ApplicationController
	layout 'admin'
	before_filter :admin_authenticated?

	def index
		@populars = Popular.all.includes(:center)
	end

	def create
		centers =  Center.unscoped.find(params['t1'].keys)
		category = Category.find(params[:people])
		centers.each do |center|
			Popular.create(center: center, category: category)
		end
		redirect_to admins_populars_path, :notice => 'Populars updated'
	end

	def new 
		# only approval centers will show
		@centers = Center.all
		@categories = Category.all
	end

	def destroy
	 popular = Popular.find(params[:id])
	 if popular.delete
	 	redirect_to admins_populars_path
	 end
	end

end
end