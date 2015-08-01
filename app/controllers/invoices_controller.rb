class InvoicesController < ApplicationController
  before_filter :is_user, only: :show
  before_action :passport, only: :show
  before_action :verify_user, only: :service

   def show
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
    @service = @order.order_items.last.service
    respond_to do |format|
       format.pdf {
         send_data @service.receipt(@order).render,
           filename: "#{@service.created_at.strftime("%Y-%m-%d")}-fitnesspapa-receipt.pdf",
           type: "application/pdf",
           disposition: :inline
       }
     end
   end

   private

     def passport
       @passport = current_user.passport
     end
     def is_user
      redirect_to root_url unless current_user
     end

     def verify_user
      @order = Order.find_by_number(params[:order_id])
      customer = current_user.blank? ? current_service_order.customer : current_user
      redirect_to root_url unless customer == @order.customer
     end
end
