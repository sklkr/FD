class MypackageController < ApplicationController
  protect_from_forgery :except => [:success, :failure]
  before_action :authenticated?
  before_action :check_hash, :only => [:success]
  layout 'payments'

  def index
  	@order = current_order || Order.new(:email_address => current_user.customer.email, customer: current_user.customer)
    @order.order_items.new(:quantity => 1, :unit_price => 1500, :order_type => 'Package')
    if @order.save
      @payu = PayuService.new(@order, current_user, mypackage_success_url, mypackage_failure_url)
    else
      redirect_to root_url, :notice => "Something went wrong"
  	end
  end

  def success
    @order = current_order || Order.find_by_number(params[:txnid])
    @order.update_attributes(params.permit(:status, :bank_ref_num, :bankcode, :name_on_card, :cardnum, :amount_split, :discount, :net_amount_debit))
    
    Passport.create(:order_item => @order.order_items.first, :customer => current_user.customer, tickets: 30, active: 0)

    #sms 
    @c = @order.customer
    @customer_data = @c.user
    SmsService.new(@customer_data.phone, "Hi, you\'ve bought a FitnessPapa Passport from Fitnesspapa worth Rs.#{@order.total_amount}. Your order ID is #{@order.number}.").send_sms
  end

  def failure
    render :text => "Payment Failed"
  end

  private
  	def generate_hash(*fields)
  	  
  	end

    def check_hash
      redirect_to root_url unless hash_checker
    end

    def hash_checker
      fields = "#{Figaro.env.payu_secret}|#{params[:status]}|||||||||||#{params[:email]}|#{params[:firstname]}|#{params[:productinfo]}|#{params[:amount]}|#{params[:txnid]}|#{Figaro.env.payu_key}"
      params[:hash] == Digest::SHA2.new(512).hexdigest(fields)
    end
end

