module Fpadmin
class CustomersController < BaseController 
layout 'fpadmin'
before_filter :authenticated?

  def index
    @customers = Customer.recent.includes(:user, :passport).page params[:page]
  end

  def show
    @customer = Customer.find(params[:id])
    @order = @customer.passport
    @reservations = @order.blank? ? nil : @order.clasbkings
  end

  def destroy
  	@customer = Customer.find(params[:id])
  	if @customer.destroy
  		redirect_to :action => 'index'
  	else
  		render :text => 'something went wrong'
  	end
  end
end
end