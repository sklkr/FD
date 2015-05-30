class AcknowledgeOrder < MandrillMailer::TemplateMailer
  default from: "noreply@fitnesspapa.com"

  def customer(passport, user)
    mandrill_mail(
      template: 'acknowledge_order',
      subject: "FitnessPapa Passport Purchase",
      to: user.customer.email,
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'NAME' => user.full_name,
        'DATE' => passport.start_date,
        'ORDER_ID' => passport.order_id,
        'EXPIRED_ON' => passport.end_date,
      },
      important: true,
      inline_css: true,
    )
  end

  def admin(passport, user)
    mandrill_mail(
      template: 'acknowledge_order_to_admin',
      subject: "FitnessPapa Passport Purchase",
      to: 'support@fitnesspapa.com',
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'NAME' => user.full_name,
        'DATE' => passport.start_date,
        'EMAIL' => passport.order_id,
        'MOBILE' => user.phone,
      },
      important: true,
      inline_css: true,
    )
  end
end
  