module Customers
class MypassController < ApplicationController 
layout 'customerdashboard'
  def index
  	mypasses = []
  	@mypasses = current_user.customer.orders.includes(:order_items).each {|order| mypasses << order.order_items}.flatten
  end
end
end