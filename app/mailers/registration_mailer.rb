class RegistrationMailer < MandrillMailer::TemplateMailer
  default from: 'info@fitnesspapa.com'
  default from_name: 'FitnessPapa'

  def customer_notify(cb)
    user    = cb.customer # cb = clasbking
    fpclass = cb.fpclass
    center  = cb.center

    mandrill_mail(
      template: 'reservation_acknowledgement_customer',
      subject: "Reservation Acknowledgement",
      to: user.email,
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'SUBJECT' => 'Reservation Acknowledgement',
        'CLASSNAME' => fpclass.name,
        'CENTERNAME' => center.name,
        'LOCATION' => center.place_name,
        'DATE' => "#{cb.expired_at} #{cb.expired_humanize}"
      },
      important: true,
      inline_css: true,
    )
  end

  def partner_notify(cb)
    user    = cb.customer
    fpclass = cb.fpclass
    center  = cb.center

    mandrill_mail(
      template: 'reservation_acknowledgement_partner',
      subject: "Reservation Acknowledgement",
      to: center.email,
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'SUBJECT' => 'Customer Reservation',
        'CUSTOMER' => user.full_name,
        'MOBILE' => user.phone,
        'LOCATION' => center.place_name,
        'CLASSNAME' => fpclass.name,
        'CENTERNAME' => center.name,
        'DATE' => "#{cb.expired_at} #{cb.expired_humanize}"
      },
      important: true,
      inline_css: true,
    )
  end

  def customer_cancel(cb)
    user    = cb.customer
    fpclass = cb.fpclass
    center  = cb.center

    mandrill_mail(
      template: 'reservation_cancellation_customer',
      subject: "Reservation Cancellation",
      to: user.email,
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'SUBJECT' => 'Reservation Cancellation',
        'CLASSNAME' => fpclass.name,
        'CENTERNAME' => center.name,
        'LOCATION' => center.place_name,
        'DATE' => "#{cb.expired_at} #{cb.expired_humanize}"
      },
      important: true,
      inline_css: true,
    )
  end

  def partner_cancel(cb)
    user    = cb.customer
    fpclass = cb.fpclass
    center  = cb.center

    mandrill_mail(
      template: 'reservation_cancellation_partner',
      subject: "Reservation Cancellation",
      to: center.email,
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'SUBJECT' => 'Reservation Cancellation',
        'CUSTOMER' => user.full_name,
        'MOBILE' => user.phone,
        'CLASSNAME' => fpclass.name,
        'CENTERNAME' => center.name,
        'LOCATION' => center.place_name,
        'DATE' => "#{cb.expired_at} #{cb.expired_humanize}"
      },
      important: true,
      inline_css: true,
    )
  end
  

  def admin_notify(cb)
    user    = cb.customer
    fpclass = cb.fpclass
    center  = cb.center

    mandrill_mail(
      template: 'reservation_acknowledgement_admin',
      subject: "Reservation Notification",
      to: 'support@fitnesspapa.com',
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'SUBJECT' => 'Customer Reservation',
        'CUSTOMER' => user.full_name,
        'MOBILE' => user.phone,
        'CLASSNAME' => fpclass.name,
        'LOCATION' => center.place_name,
        'CENTERNAME' => center.name,
        'DATE' => "#{cb.expired_at} #{cb.expired_humanize}"
      },
      important: true,
      inline_css: true,
    )
  end

  def admin_cancel(cb)
    user    = cb.customer
    fpclass = cb.fpclass
    center  = cb.center

    mandrill_mail(
      template: 'reservation_cancellation_admin',
      subject: "Revervation Cancellation",
      to: 'support@fitnesspapa.com',
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'SUBJECT' => 'Cancel Reservation',
        'CUSTOMER' => user.full_name,
        'MOBILE' => user.phone,
        'CLASSNAME' => fpclass.name,
        'LOCATION' => center.place_name,
        'CENTERNAME' => center.name,
        'DATE' => cb.expired_at
      },
      important: true,
      inline_css: true,
    )
  end

  def send_manual(customer)
    mandrill_mail(
      template: 'REGISTRATION_PROCESS',
      subject: "Welcome to FitnessPapa Community",
      to: customer.email,
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'SUBJECT' => 'Welcome FitnessPapa Passport Community',
         'LINK' => customer.remember_token
      },
      important: true,
      inline_css: true,
    )
  end
end

