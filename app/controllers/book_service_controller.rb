class BookServiceController < ApplicationController
	layout 'services'
	include Wicked::Wizard
	steps :info, :payment
	protect_from_forgery :except => [:success, :failure]
	before_action :check_hash, :only => [:success]


	def show
		case step
		when :info
			service = Service.friendly.find(params[:service])
			@order =  current_service_order || Order.new 
			@order.order_items.each(&:delete) unless @order.order_items.empty?
			@order.order_items.build(:quantity => 1, :unit_price => service.selling_price, :service_id => service.id, :order_type => 'Service')
			if @order.save
				session[:service_id] = @order.id
			end
			@user = which_user
		when :payment
			@service = current_service_order.order_items.last.service
			@order = current_service_order
			@payu = PayuService.new(@order, @order.customer, book_service_success_url, book_service_failure_url)
		end

		render_wizard
	end

	def success
		@order = current_service_order
	    @order.update_attributes(params.permit(:status, :bank_ref_num, :bankcode, :name_on_card, :cardnum, :amount_split, :discount, :net_amount_debit))
	    @order.pg_type = params['PG_TYPE']
	    @order.save
	  
	    #sms
	    SmsService.new(@customer.phone, "You have bought one day pass at #{} having order id #{}. Thank You!").delay.send_sms
	    # AcknowledgeOrder.customer(@passport, current_user).delay.deliver
	    # AcknowledgeOrder.admin(@passport, current_user).delay.deliver
	  
	    redirect_to service_invoice_path(order_id: @order.number, format: :pdf)
	end

	def failure
		render :text => "Payment Failed"
	end

	def update
		case step
		when :info
			# Build guest user
			@customer = customer
			current_service_order.update(:email_address => @customer.email, customer: @customer)
			render_wizard current_service_order
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
end
