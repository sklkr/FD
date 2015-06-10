class MypackageController < ApplicationController
  protect_from_forgery :except => [:success, :failure]
  before_action :authenticated?
  before_action :check_hash, :only => [:success]
  before_action { Date.today.to_s == "11th june" } 
  layout 'payments'

  def index
    @order = current_order || Order.new(:email_address => current_user.email, customer: current_user)
    @order.order_items.new(Passport::TYPE[Passport::ACTIVE].except(:tickets, :end_date))
    
    if @order.save
      @payu = PayuService.new(@order, current_user, mypackage_success_url, mypackage_failure_url)
    else
      # Checklist :: ------------ Change root url to somewhere nice
      redirect_to root_url, :notice => "Something went wrong"
  	end
  end

  def success
    
    @order = current_order || Order.find_by_number(params[:txnid])
    @order.update_attributes(params.permit(:status, :bank_ref_num, :bankcode, :name_on_card, :cardnum, :amount_split, :discount, :net_amount_debit))
    
    data = Passport::TYPE[Passport::ACTIVE]
    
    @passport = Passport.new(:tickets => data[:tickets], :order_item => @order.order_items.first, :customer => current_user, active: 0, :start_date => Date.today, :end_date => data[:end_date])
    @customer = @order.customer
    
    unless @passport.save && (current_user.passport.try(:order_item_id) != @order.order_items.first.id)
      redirect_to root_url, :notice => 'something went wrong'
    end
    #sms 
    
    SmsService.new(@customer.phone, "Hi, you\'ve bought a FitnessPapa Passport worth Rs.#{@order.total_amount} on #{@passport.start_date}. Your order ID is #{@passport.order_id}.   Thank You!").delay.send_sms
    AcknowledgeOrder.customer(@passport, current_user).delay.deliver
    
    AcknowledgeOrder.admin(@passport, current_user).delay.deliver
    
  end

  def failure
    render :text => "Payment Failed"
  end

  private
  	
    def check_hash
      redirect_to root_url unless hash_checker
    end

    def hash_checker
      fields = "#{Figaro.env.payu_secret}|#{params[:status]}|||||||||||#{params[:email]}|#{params[:firstname]}|#{params[:productinfo]}|#{params[:amount]}|#{params[:txnid]}|#{Figaro.env.payu_key}"
      params[:hash] == Digest::SHA2.new(512).hexdigest(fields)
    end
end

