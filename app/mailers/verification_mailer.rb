class VerificationMailer < MandrillMailer::MessageMailer
  default from: "noreply@fitnesspapa.com"

  def welcome_email(user, role)
  	  @link = url_for( :controller => 'registrations', :action => 'verify_email', :token => user.remember_token )
      @role = role
      mandrill_mail(
       template: 'verification',
       subject: "Email Verification",
       to: @role.email,
        # to: invitation.email,
        # to: { email: invitation.email, name: 'Honored Guest' },
       vars: {
        'VERIFY_URL' => @link,
       },
       important: true,
       inline_css: true,
      )
  end

  def guest_email(role)
  	  @email = role.email
  	  mail(to: role.email, subject: 'Welcome to FitnessPapa')
  end
end
