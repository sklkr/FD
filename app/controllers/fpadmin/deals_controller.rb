## Admin Dashboard >> Deals

module Fpadmin
class DealsController < BaseController 
layout 'fpadmin'
before_filter :authenticated?

  def index
    @deals = Deal.all
  end

  def new
    @deal = Deal.new
  end

  def create
    @deal = Deal.new(permit_params)
    if @deal.save
      flash[:notice] = "Deal Created successfully"
      redirect_to action: :index
    else
      render :new
    end
  end

  private
    def permit_params
      params.require(:deal).permit(:brand, :bemail, :bmobile, :name, :address, :original_price, :selling_price, :about, :quantity, :city, :sublocation, :image, :category => [], :subcategory => [], :timings => [])
    end
end
end