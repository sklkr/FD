class BookingsController < ApplicationController
before_filter :check_auth, :only => [:add_details]
before_filter :searcher
require 'digest/sha1'

  def index
  	@title = "Book Now"
  	@service = Center.friendly.find(params['center_id']).services.friendly.find(params['id'])
  end

  def create
  	@booking = Booking.new(params.permit(:quantity))
  	service = Service.friendly.find(params[:service_name])
  	@booking.service_id = service.id
    @booking.partner_id = service.center.partner.id
    @booking.center_id = service.center.id
    @booking.service_type = 2 if service.is_pass?
  	unless current_user.nil?
     	@booking.customer_id = current_user.id 
  	end
  	@booking.price = service.selling_price * @booking.quantity
  	if @booking.save
  		redirect_to add_details_path(params["center_id"], params["service_name"], :token => @booking.token)
  	else
      flash['model_errors'] = @booking.errors.messages
  		render :index
  	end
  end
  
  def add_details
  	@title = 'User Details'
  	@booking = Booking.find_by_token(params[:token])
  end



  private
  	def check_auth
      redirect_to sessions_checker_path(:url => params[:token]) unless warden.authenticated? 
    end

    def searcher
      # temporary
      redirect_to root_url
    end
end
