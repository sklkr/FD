class PaymentsController < ApplicationController
  protect_from_forgery :except => [:success, :failure]

  def index
    @booking = Booking.find_by_token(params[:token])
  	@key = 'JBZaLc'
  	@amount = @booking.price
  	@surl = payments_success_url
  	@furl = payments_failure_url
  	@service_provider = 'payu_paisa'
  	@txnid = params[:token]
  	@email = current_user.customer.email
  	@phone = current_user.phone
  	@productinfo =  @booking.service.name
  	@firstname = current_user.first_name
    @authenticity_token = params[:authenticity_token]
  	@hash = generate_hash(@key, @txnid, @amount, @productinfo, @firstname, @email, @authenticity_token)
  end

  def success
    @booking = Booking.find_by_token(params[:txnid])
    @service = @booking.service
    @center = @service.center
  end

  def failure
    
  end

  private
  	def generate_hash(*fields)
  	  fields = fields.join('|')
  	  fields << '||||||||||GQs7yium'
      
  	  Digest::SHA2.new(512).hexdigest fields
  	end

  	def get_fields

  	end
end
