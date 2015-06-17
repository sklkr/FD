class VerificationMailer < ActionMailer::Base
  default from: "noreply@fitnesspapa.com"
  
  def welcome_email(user, role)

      @verify_url = url_for( :controller => 'registrations', :action => 'verify_email', :token => user.remember_token )
      @role = role
      mail(to: @role.email, subject: "Email Verification")
  end

  def guest_email(role)
  	  @email = role.email
  	  mail(to: role.email, subject: 'Welcome to FitnessPapa')
  end
end
