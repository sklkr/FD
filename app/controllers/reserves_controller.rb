class ReservesController < ApplicationController
before_action :authenticated?
before_action :is_passport
before_action :is_available_tickets, except: :destroy
before_action :is_available_seats, except: :destroy

	def show
		@fpclass = Fpclass.friendly.find(params[:id])
		@center = @fpclass.centers.first
		respond_to do |format|
			format.js
		end
	end

	def create
		@fpclass = Fpclass.friendly.find(params[:id])
		@conditioner = FpConditioner.new(@fpclass, self)
		if @conditioner.is_he_eligible
			@booking = Clasbking.new(:customer => current_user, :fpclass => @fpclass, :passport => passport, :status => 'open', :expired_at => params[:date] + " " + params[:time], :center => @fpclass.centers.first)
			if @booking.save
				respond_to do |format|
					format.js
				end
			else
				render :js => 'swal("Oops...", "Something went wrong!", "error");'
			end
		else
			render :js => "swal('Oops...', '#{flash.alert}', 'error');"
		end
	end

	def destroy
		booking = Clasbking.find(params[:id])
		if booking.customer == current_user && (booking.expired_at - Date.today).to_i > 1
			SmsService.new(booking.phone_number, "Dear Partner, #{booking.customer.user.full_name} has cancelled #{booking.fpclass.name} on #{booking.expired_at} at #{booking.fpclass.start_time.strftime('%H:%M')}. @FitnessPapa").delay.send_sms
			redirect_to customers_classes_path if booking.destroy
		else
			redirect_to customers_classes_path, :notice => "You cannot cancel before one day of class scheduled date."
		end
	end

	private
		def is_passport
			render :js => "$('#package').modal('show')" if passport.blank?
		end

		def is_available_tickets
      		render :js => "swal('Oops...', 'Passport tickets gone empty. You can buy new passport to get more tickets','error')" if (passport.remaining_tickets <= 0)
		end

		def is_available_seats
			render :js => "swal('Oops...', 'All seats are full. You can check other timings','error')" if (!Fpclass.find_by_id(params[:id]).nil? && Fpclass.find(params[:id]).remaining_seats <= 0)
		end
end
