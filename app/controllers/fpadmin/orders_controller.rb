module Fpadmin
class OrdersController < BaseController 
layout 'fpadmin'
before_filter :authenticated?

  def index
    @orders = Passport.unscoped.recent.includes(:customer).page params[:page]
  end

  def show
  	
  end

  def destroy

  end
end
end