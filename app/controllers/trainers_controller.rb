class TrainersController < ApplicationController
	def new
		@trainer = Trainer.new
	end

	def create
		@trainer = Trainer.new(permit_params)
		if @trainer.save
			render :js => 'swal("Success", "Reqest sent successfully. We will contact you soon", "success");'
		else
			render :js => 'swal("Oops", "Something went wrong", "error");'
		end
	end

	private
		def permit_params
			params.require(:trainer).permit("name","phone","email","location","date","service","comment","address")
		end
end
