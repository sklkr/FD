class MypackageController < ApplicationController
  def index
  	binding.pry
  	order = Order.new(:email_address => current_user.customer.email)
  	order.order_items 
  end
end
