class CouponsController < ApplicationController


 def create
   @coupon = Coupon.find_by_code(params[:id])
   @order = current_order || Order.new(:email_address => current_user.email, customer: current_user)
   if session[:order_id].blank?
     @order.order_items.new(Passport::TYPE[Passport::ACTIVE].except(:tickets, :end_date))
     @order.save
   end
   session[:order_id] = @order.id
   unless @coupon.blank?
     @order.coupon = @coupon
     @order.save
     render json: {:coupon => params[:id], :active => true, :amount => @coupon.amount.to_i}
   else
     render json: {:coupon => params[:id], :active => false}
   end
 end

 def update
 end

 def destroy
 end

 private
    def validate_coupon

    end
end
