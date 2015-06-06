class UserMailer < MandrillMailer::TemplateMailer
  default from: "noreply@fitnesspapa.com"

  def password_reset(user)
    mandrill_mail(
      template: 'password_reset',
      subject: "Password Reset",
      to: user.email,
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
      vars: {
        'URL' => edit_password_reset_url(user.password_reset_token),
      },
      important: true,
      inline_css: true,
    )
  end
end
