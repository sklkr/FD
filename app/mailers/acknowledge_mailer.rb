class AcknowledgeMailer < MandrillMailer::TemplateMailer
  default from: "noreply@fitnesspapa.com"

  def partner_reg(partner)
  	user = partner.user
    center = partner.centers.first
    mandrill_mail(
      template: 'partner_registration',
      subject: "Registration Notification",
      to: 'support@fitnesspapa.com',
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'NAME' => user.full_name,
        'EMAIL' => partner.email,
        'MOBILE' => user.phone,
        'CENTER' => center.name,
        'PARTNER_TYPE' => partner.partner_type
      },
      important: true,
      inline_css: true,
    )
  end
end
