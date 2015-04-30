class AcknowledgeMailer < ActionMailer::Base
  default from: "FitnessPapa <noreply@fitnesspapa.com>"

  def partner_reg(partner)
  	@partner = partner
  	@details = partner.user
  	mail(to: 'partners@fitnesspapa.com', subject: 'Partner Registration')
  end

end
