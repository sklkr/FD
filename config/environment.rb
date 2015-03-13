# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


ActionMailer::Base.smtp_settings = {
   :address => "smtp.zoho.com",
   :port => 465,
   :domain => "zoho.com",
   :user_name => "noreply@fitnesspapa.com",
   :password => "wisdom@123",
   :authentication => 'plain',
   :ssl => true,
}