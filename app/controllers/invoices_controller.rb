class InvoicesController < ApplicationController
  before_filter { redirect_to root_url unless current_user }
  before_action :passport

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

   private

     def passport
       @passport = current_user.passport
     end
end
