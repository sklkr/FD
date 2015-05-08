class ReservesController < ApplicationController
before_action :authenticated?
before_action :is_passport
before_action :is_available_tickets
before_action :is_available_seats

	def create
		@fpclass = Fpclass.find(params[:class_id])
		@booking = Clasbking.new(:customer => current_user.customer, :fpclass => @fpclass, :passport => passport, :status => 'open')
		if @booking.save
			respond_to do |format|
				format.js
			end
		else
			render :json => "something went wrong"
		end
	end

	private
		def is_passport
			redirect_to root_url if passport.blank?
		end

		def is_available_tickets
			render status: 403, json: {"error" => "Tickets full"} if (passport.remaining_tickets <= 0)
		end

		def is_available_seats
			render status: 403, json: {"error" => "Seats full"} if (Fpclass.find(params[:class_id]).remaining_seats <= 0)
		end
end
