module Fpadmin
class OrdersController < BaseController 
layout 'fpadmin'

  def index
    @orders = Passport.recent.includes(:customer).page params[:page]
  end

  def show
  	
  end

  def destroy

  end
end
end