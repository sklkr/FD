class VerificationMailer < ActionMailer::Base
  default from: "FitnessPapa <noreply@fitnesspapa.com>"

  def welcome_email(user, role)
  	  @link = url_for( :controller => 'registrations', :action => 'verify_email', :token => user.remember_token )
  	  @email = role.email
  	  @name = role.user.first_name
  	  mail(to: role.email, subject: 'Welcome to FitnessPapa')
   end
end
