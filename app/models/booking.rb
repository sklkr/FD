class Booking < ActiveRecord::Base
	before_create 	:generate_token
	belongs_to :service
	private
	def generate_token
	 self.token = SecureRandom.urlsafe_base64
	end
end
