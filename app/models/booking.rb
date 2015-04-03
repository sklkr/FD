class Booking < ActiveRecord::Base
	before_create :generate_token
	belongs_to :service
	belongs_to :partner
	belongs_to :center
	belongs_to :customer
	has_many :details


	def order_id
		"OD" + sprintf('%07d', self.id)
	end

	def woprice
		self.price * 0.86
	end

	def partner_stax
		(fp * (0.1236)).round(2)
	end

	def fp
		(woprice * 0.05).round(2)
	end

	def partner_money
		(self.price - fp - partner_stax).round(2)
	end



	private
	def generate_token
	 self.token = SecureRandom.urlsafe_base64
	end
end
