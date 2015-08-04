# Admin Dashboard >> Orders >> Invoice

module Fpadmin
class InvoiceController < BaseController 
layout 'fpadmin'
before_filter :authenticated?

  def show
   @passport = Passport.unscoped.find(params[:id]) 
   respond_to do |format|
     format.pdf {
       send_data @passport.receipt.render,
         filename: "#{@passport.created_at.strftime("%Y-%m-%d")}-fitnesspapa-receipt.pdf",
         type: "application/pdf",
         disposition: :inline
     }
   end
  end

  def service
    @order = Order.find_by_number(params[:id])
    @service = @order.service_order_item.service
    respond_to do |format|
       format.pdf {
         send_data @service.receipt(@order).render,
           filename: "#{@order.updated_at.strftime("%Y-%m-%d")}-fitnesspapa-receipt.pdf",
           type: "application/pdf",
           disposition: :inline
       }
     end
  end
end
end