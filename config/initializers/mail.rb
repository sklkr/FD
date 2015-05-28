ActionMailer::Base.smtp_settings = {
   :address => "smtp.mandrillapp.com",
   :port => 587,
   :user_name => "support@fitnesspapa.com",
   :password => "uGj2DNHKtPtojEYeoLoyVA",
   :authentication => 'plain',
   :ssl => true,
}


ActionMailer::Base.delivery_method = :smtp

MandrillMailer.configure do |config|
  config.api_key = "uGj2DNHKtPtojEYeoLoyVA"
end
