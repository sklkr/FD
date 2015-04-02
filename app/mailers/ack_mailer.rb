class AckMailer < ActionMailer::Base
  default from: "FitnessPapa <noreply@fitnesspapa.com>"

  def customer(token)
  	@booking = Booking.find_by_token(token)
  	@user = @booking.customer
    @service = @booking.service
    @details = @booking.details
    e = @user.email
  	mail(to: e , subject: 'Thankyou for buying service at FitnessPapa')
  end

  def partner(token)
  	@booking = Booking.find_by_token(token)
  	@user = @booking.partner
  	@center = @booking.center
  	@service = @booking.service
  	@details = @booking.details
    mail(to: @user.email , subject: 'You have received booking service by customer at FitnessPapa')
  end
end
