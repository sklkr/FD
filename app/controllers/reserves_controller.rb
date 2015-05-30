class ReservesController < ApplicationController
before_action :authenticated?
before_action :is_passport
before_action :is_available_tickets
before_action :is_available_seats
	
	def show
		@fpclass = Fpclass.friendly.find(params[:id])
		@center = @fpclass.centers.first
		respond_to do |format|
			format.js
		end
	end

	def create
		@fpclass = Fpclass.friendly.find(params[:id])
		@conditioner = FpConditioner.new(@fpclass, passport)
		if @conditioner.is_he_eligible
			@booking = Clasbking.new(:customer => current_user.customer, :fpclass => @fpclass, :passport => passport, :status => 'open', :expired_at => params[:date], :center => @fpclass.centers.first)
			if @booking.save
				respond_to do |format|
					format.js
				end
			else
				render :js => "alert('something went wrong');"
			end
		else
			render :js => "alert('you are not eligible to reserve on this class');"
		end
	end

	def destroy
		booking = Clasbking.find(params[:id])
		if booking.customer == current_user.customer && (booking.expired_at - Date.today).to_i > 1
			redirect_to customers_classes_path if booking.delete
		else
			redirect_to customers_classes_path, :notice => "You cannot cancel before one day of class scheduled date."
		end
	end

	private
		def is_passport
			render :js => "$('#package').modal('show')" if passport.blank?
		end

		def is_available_tickets
			render :js => "alert('Passport tickets are full. You can buy new passport to get more tickets')" if (passport.remaining_tickets <= 0)
		end

		def is_available_seats
			render status: 403, json: {"error" => "Seats full"} if (!Fpclass.find_by_id(params[:id]).nil? && Fpclass.find(params[:id]).remaining_seats <= 0)
		end
end
