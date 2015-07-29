class TrainerMailer < MandrillMailer::TemplateMailer
  default from: "noreply@fitnesspapa.com"
  default from_name: 'FitnessPapa'

  def inform_admin(trainer)
    mandrill_mail(

      template: 'trainer_request',
      subject: "Trainer Request",
      to: 'partners@fitnesspapa.com',
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'NAME' => trainer.name,
        'EMAIL' => trainer.email,
        'PHONE' => trainer.phone,
        'LOCATION' => trainer.location,
        'DATE' => trainer.date,
        'SERVICE' => trainer.service,
        'COMMENT' => trainer.comment,
        'ADDRESS' => trainer.address
      },

      important: true,
      inline_css: true,
    )
  end

  def inform_customer(trainer)
    mandrill_mail(

      template: 'trainer_request',
      subject: "Trainer Request Acknowledgement from FitnessPapa",
      to: trainer.email,
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'TICKETID' => trainer.number,
        'NAME' => trainer.name,
        'ADDRESS' => trainer.address,
        'LOCATION' => trainer.location,
        'SERVICE' => trainer.service,
        'DATE' => trainer.date
      },

      important: true,
      inline_css: true,
    )
  end
end
