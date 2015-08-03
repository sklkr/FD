class ServiceMailer < MandrillMailer::TemplateMailer
  default from: "noreply@fitnesspapa.com"
  default from_name: 'FitnessPapa'

  def inform_admin(order, customer, center)
    mandrill_mail(

      template: 'service_request',
      subject: "Service Request",
      to: 'partners@fitnesspapa.com',
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'NAME' => customer.full_name,
        'EMAIL' => customer.email,
        'PHONE' => customer.phone,
        'CENTERNAME' => center.name,
        'DATE' => order.updated_at.strftime('%d %M/%Y'),
        'SERVICEID' => order.number,
      },

      important: true,
      inline_css: true,
    )
  end

  def inform_customer(order, customer, center)
    mandrill_mail(

      template: 'service_request_customer',
      subject: "Service Booking Acknowledgement from FitnessPapa",
      to: customer.email,
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'NAME' => customer.full_name,
        'SERVICEID' => order.number,
        'CENTERNAME' => center.name,
        'DATE' => order.updated_at.strftime('%d %M/%Y'),
        'ADDRESS' => center.centerinfo.address,
      },

      important: true,
      inline_css: true,
    )
  end
end
