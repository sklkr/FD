class ServicesController < ApplicationController
	def index
		
	end

	def search
		params[:q] = {:center_place_name_cont_any => params[:place_name_cont_any], :center_center_type_in => params[:center_type_in].blank? ? '' : JSON.parse(params[:center_type_in])} unless params[:place_name_cont_any].blank?
 	    @s = Service.ransack(params[:q])
   		@services = @s.result(distinct: true)
	    render json: [@services]
	end
end
