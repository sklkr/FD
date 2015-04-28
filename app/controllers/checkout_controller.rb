class CheckoutController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :should_authenticate

  def signin
 	 	
  end

  def step1
  	
  end

  def create
    order = Order.new(params_builder)
    if order.save
      redirect_to payments_index_path(:token => order.token)
    else
      flash[:notice] = "Something seems not right. Please try again"
      render 'step1'
    end
  end

  def step2
  	
  end

  def success

  end

  private
    def params_builder
      list = {:email_address => current_user.try(:customer).try(:email)}
      items = (1..params["itemCount"].to_i).collect { |no| {no => {:order_id => 1, :quantity => params["item_quantity_#{no}"], :unit_price => params["item_price_#{no}"], :service_id => Service.friendly.find(params["item_options_#{no}"].split(": ")[1]).try(:id)}}}
      order_items_attributes = {}
      items.each  {|item| order_items_attributes.merge!(item) }
      list.merge!({:order_items_attributes => order_items_attributes})
    end
end
