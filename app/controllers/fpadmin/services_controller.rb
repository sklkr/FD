# Admin Dashboard >> Services

module Fpadmin
class ServicesController < BaseController 
layout 'fpadmin'
before_filter :authenticated?

  def customer_confirmation
    @customer = Customer.find(params[:customer_id])
    if @customer && RegistrationMailer.send_manual(@customer).delay.deliver
      render :js => "swal('Success', 'Confirmation Sent to #{@customer.full_name}', 'success');"
    else
      render :js => 'swal("Oops...", "Something went wrong!", "error");'
    end
  end

end
end