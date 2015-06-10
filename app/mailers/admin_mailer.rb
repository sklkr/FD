class AdminMailer < MandrillMailer::TemplateMailer
  default from: 'info@fitnesspapa.com'

  def customer_registration(customer)
    
    mandrill_mail(
      template: 'customer_registration_admin',
      subject: "Customer Registration",
      to: 'support@fitnesspapa.com',
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'SUBJECT' => 'Customer Reservation',
        'NAME' => customer.full_name,
        'MOBILE' => customer.phone,
        'EMAIL' => customer.email,
      },
      important: true,
      inline_css: true,
    )
  end
end

