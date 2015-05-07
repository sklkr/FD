class AckMailer < ActionMailer::Base
  default from: "FitnessPapa <noreply@fitnesspapa.com>"

  def customer(token)
  	@booking = Booking.find_by_token(token) || Booking.find_by_number(token)
  	@user = @booking.customer
    @service = @booking.service
    @details = @booking.details
    e = @user.email
  	mail(to: e, subject: 'Booking confirmation with FitnessPapa.com')
  end

  def partner(token)
  	@booking = Booking.find_by_token(token)
  	@user = @booking.partner
  	@center = @booking.center
  	@service = @booking.service
  	@details = @booking.details
    mail(to: @user.email , subject: 'Customer booking service request')
  end

  def atop(message, email)
    # from admin to partners
    @message = message
    mail(to: email , subject: 'Admin alert')
  end
end
