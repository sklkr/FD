class ReservesController < ApplicationController
before_action :authenticated?
before_action :is_passport
before_action :is_available_tickets
before_action :is_available_seats
	
	def show
		@fpclass = Fpclass.find(params[:id])
		@center = @fpclass.centers.first
		respond_to do |format|
			format.js
		end
	end

	def create
		@fpclass = Fpclass.find(params[:id])
		if !(passport.clasbkings.where('fpclass_id=?', @fpclass.id).count < 3 ) || !(passport.clasbkings.count < 7)
			@booking = Clasbking.new(:customer => current_user.customer, :fpclass => @fpclass, :passport => passport, :status => 'open', :expired_at => @fpclass.date)
			if @booking.save
				respond_to do |format|
					format.js
				end
			else
				render :json => "something went wrong"
			end
		else
			render js: "alert('one can book 7 active passes with only 3 repetive classes');"
		end
	end

	private
		def is_passport
			render :js => "$('#package').modal('show')" if passport.blank?
		end

		def is_available_tickets
			redirect_to(root_url, :notice => "Tickets full") if (passport.remaining_tickets <= 0)
		end

		def is_available_seats
			render status: 403, json: {"error" => "Seats full"} if (!Fpclass.find_by_id(params[:id]).nil? && Fpclass.find(params[:id]).remaining_seats <= 0)
		end
end
