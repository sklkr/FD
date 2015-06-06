class PaymentsController < ApplicationController
  protect_from_forgery :except => [:success, :failure]

  def index
    @order = Order.find_by_token(params[:token])

  	@key = Figaro.env.payu_key
  	@amount = @order.total_amount.to_i
  	@surl = payments_success_url
  	@furl = payments_failure_url
  	@service_provider = 'payu_paisa'
  	@txnid = params[:token]
  	@email = current_user.email
  	@phone = current_user.phone
  	@productinfo = "FitnessPapa Services"
  	@firstname = current_user.first_name
    @authenticity_token = "d43kl34hln2hk"
  	@hash = generate_hash(@key, @txnid, @amount, @productinfo, @firstname, @email, @authenticity_token)
  end

  def success
    @order = Order.find_by_token(params[:txnid])    
    @order.status = params["status"]
    @order.save
    @service = @order.service
    @center = @service.center

    #sms 
    @customer = @order.customer
    @customer_data = @customer.user
    @partner = @order.partner
    @partner_data = @partner.user

    SmsService.new(@customer_data.phone, "Hi, you\'ve bought a #{@service.name} from Fitnesspapa at #{@center.name} worth Rs.#{@order.price}. Your order ID is #{@order.order_id}.").send_sms
    SmsService.new(@partner_data.phone, "Hi, #{@customer_data.first_name} has bought a #{@service.name} from Fitnesspapa at #{@center.name} worth Rs.#{@order.price}. The order ID is #{@order.order_id}.").send_sms
    AckMailer.customer(@order.token).deliver
    AckMailer.partner(@order.token).deliver
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
