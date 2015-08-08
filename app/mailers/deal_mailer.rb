class DealMailer < MandrillMailer::TemplateMailer
  default from: "noreply@fitnesspapa.com"
  default from_name: 'FitnessPapa'

  def inform_admin(order, customer, deal)
    mandrill_mail(

      template: 'deal_request',
      subject: "Deal Request",
      to: 'partners@fitnesspapa.com',
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'NAME' => customer.full_name,
        'EMAIL' => customer.email,
        'PHONE' => customer.phone,
        'ORDERID' => order.number,
        'DATE' => order.updated_at.strftime('%d %M/%Y'),
        'DEALNAME' => deal.name,
      },

      important: true,
      inline_css: true,
    )
  end

  def inform_customer(order, customer, deal)
    mandrill_mail(

      template: 'deal_request_customer',
      subject: "Deal Booking Acknowledgement from FitnessPapa",
      to: customer.email,
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'NAME' => customer.full_name,
        'ORDERID' => order.number,
        'DEALNAME' => deal.name,
        'DATE' => order.updated_at.strftime('%d %M/%Y'),
        'ADDRESS' => deal.address,
      },

      important: true,
      inline_css: true,
    )
  end
end
