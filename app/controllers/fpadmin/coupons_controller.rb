# Admin Dashboard >> Coupons

module Fpadmin
class CouponsController < BaseController
layout 'fpadmin'
before_filter :authenticated?

  def index
   @coupons = Coupon.all
  end

  def new
    @coupon = Coupon.new
  end

  def create
    @coupon = Coupon.new(permit_params)
    if @coupon.save
      redirect_to action: :index, :notice => "Coupon Added"
    else
      render 'new'
    end
  end

  def destroy
  end

  private
    def permit_params
      params.require(:coupon).permit(:code, :expires_at, :percent, :amount)
    end
end
end
