class Booking < ActiveRecord::Base
	before_create :generate_token
	belongs_to :service
	belongs_to :partner
	belongs_to :center
	belongs_to :customer
	has_many :details

	private
	def generate_token
	 self.token = SecureRandom.urlsafe_base64
	end
end
