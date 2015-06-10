class AcknowledgeMailer < MandrillMailer::TemplateMailer
  default from: "noreply@fitnesspapa.com"

  def partner_reg(partner)
  	center = partner.centers.first
    mandrill_mail(

      template: 'partner_registration',
      subject: "Registration Notification",
      to: 'partners@fitnesspapa.com',
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'NAME' => partner.full_name,
        'EMAIL' => partner.email,
        'MOBILE' => partner.phone,
        'CENTER' => center.name,
        'PARTNER_TYPE' => partner.partner_type
      },
      important: true,
      inline_css: true,
    )
  end
end
