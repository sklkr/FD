class DealsController < ApplicationController
	def index
		@deals = Deal.all					
	end

	def create
		params[:q] = {:city_cont_any => params[:place_name_cont_any].blank? ? '' : params[:place_name_cont_any] , :category_in => params[:center_type_in].blank? ? '' : params[:center_type_in].last}
    	@c = Deal.ransack(params[:q])
    	@deals = @c.result(distinct: true)
    	render 'index'
	end
end
