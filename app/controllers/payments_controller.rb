class PaymentsController < ApplicationController
  protect_from_forgery :except => [:success, :failure]

  def index
    @booking = Booking.find_by_token(params[:token])

    (1..params['gender'].count).each do |n|
      Detail.create(:name => params['name'].values[n-1], :gender => params['gender'].values[n-1], :mobile => params['mobile'], :request => params['request'], :booking_id => @booking.id)
    end

  	@key = Figaro.env.payu_key
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
    @booking.status = params["status"]
    @booking.save
    @service = @booking.service
    @center = @service.center

    #sms 
    @customer = @booking.customer
    @customer_data = @customer.user
    @partner = @booking.partner
    @partner_data = @partner.user

    SmsService.new(@customer_data.phone, "Hi, you\'ve bought a #{@service.name} from Fitnesspapa at #{@center.name} worth Rs.#{@booking.price}. Your order ID is #{@booking.order_id}.").send_sms
    SmsService.new(@partner_data.phone, "Hi, #{@customer_data.first_name} has bought a #{@service.name} from Fitnesspapa at #{@center.name} worth Rs.#{@booking.price}. The order ID is #{@booking.order_id}.").send_sms
    AckMailer.customer(@booking.token).deliver
    AckMailer.partner(@booking.token).deliver
  end

  def failure
    
  end

  private
  	def generate_hash(*fields)
  	  fields = fields.join('|')
  	  fields << "||||||||||#{Figaro.env.payu_secret}"
      
  	  Digest::SHA2.new(512).hexdigest fields
  	end

  	def get_fields

  	end
end
