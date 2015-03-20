class UserMailer < ActionMailer::Base
  default from: "FitnessPapa <noreply@fitnesspapa.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user, role)
    @user = user
    mail :to => role.email, :subject => "Password Reset"
  end
end
