class BookDealController < ApplicationController
	layout 'deals'
	include Wicked::Wizard
	steps :info, :login, :facebook, :payment
	protect_from_forgery :except => [:success, :failure]
	before_action :check_hash, :only => [:success]


	def show
		case step
		when :info
			deal = Deal.friendly.find(params[:deal])
			@order =  current_deal_order || Order.new 
			@order.order_items.each(&:delete) unless @order.order_items.empty?
			@order.order_items.build(:quantity => 1, :unit_price => deal.selling_price, :deal_id => deal.id, :order_type => 'Deal')
			if @order.save
				session[:deal_id] = @order.id
			end
			if current_user.blank?
				session[:book_deal] = '1'
				render_wizard
			else
				@order.customer = current_user
				@order.save
				prepare_payment
			end
		when :facebook
			session[:book_deal] = nil
			order = current_deal_order
			order.customer = current_user
			order.save
			prepare_payment
			render_wizard
		when :payment
			prepare_payment
		end
	end

	def success
		@order = current_deal_order
	    @order.update_attributes(params.permit(:status, :bank_ref_num, :bankcode, :name_on_card, :cardnum, :amount_split, :discount, :net_amount_debit))
	    @order.pg_type = params['PG_TYPE']
	    @order.save
	  
	    #Acknowledgements
	    @customer = @order.customer
	    @deal = @order.deal_order_item.deal
	    SmsService.new(@customer.phone, "You have bought #{@deal.name} having order id #{@order.number}. Thank You!").send_sms
	    SmsService.new(@deal.bmobile, "#{@customer.full_name} has bought  at #{@deal.name} having order id #{@order.number} on #{@order.updated_at.strftime("%d %M/%Y")}. Thanks!").delay.send_sms
	    DealMailer.inform_customer(@order, @customer, @deal).delay.deliver
	    DealMailer.inform_admin(@order, @customer, @deal).delay.deliver
	    
	    redirect_to deal_invoice_path(order_id: @order.number, format: :pdf)
	end

	def failure
		render :text => "Payment Failed"
	end

	def update
		case step
		when :login
			authenticate!
			order = current_deal_order
			order.customer = current_user
			order.save
			prepare_payment
			render_wizard
		end
	end

	private
		def redirection_options
			
		end

		def customer
			Customer.find_by_email(params[:customer][:email]) || Customer.create(params.require(:customer).permit(:email, :user_attributes => [:full_name, :phone]))
		end

	    def check_hash
	      redirect_to root_url unless hash_checker
	    end

	    def hash_checker
	      fields = "#{Figaro.env.payu_secret}|#{params[:status]}|||||||||||#{params[:email]}|#{params[:firstname]}|#{params[:productinfo]}|#{params[:amount]}|#{params[:txnid]}|#{Figaro.env.payu_key}"
	      params[:hash] == Digest::SHA2.new(512).hexdigest(fields)
	    end

	    def prepare_payment
			@order = current_deal_order
	    	@deal = @order.deal_order_item
			@payu = PayuService.new(@order, @order.customer, book_deal_success_url, book_deal_failure_url)
	    end
end
