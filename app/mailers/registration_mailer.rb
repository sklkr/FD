class RegistrationMailer < MandrillMailer::TemplateMailer
  default from: 'info@fitnesspapa.com'

  def admin_notify(cb)
    user    = cb.customer.user
    fpclass = cb.fpclass
    center  = cb.center

    mandrill_mail(
      template: 'reservation',
      subject: "Registration Notification",
      to: 'support@fitnesspapa.com',
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'SUBJECT' => 'Customer Reservation',
        'CUSTOMER' => user.full_name,
        'MOBILE' => user.phone,
        'CLASSNAME' => fpclass.name,
        'CENTERNAME' => center.name,
        'DATE' => cb.expired_at
      },
      important: true,
      inline_css: true,
    )
  end
end
