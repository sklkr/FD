class Clasbking < ActiveRecord::Base
    default_scope  { where('expired_at >= ?', Time.now) }
    after_create :tell_partner

	belongs_to :customer
	belongs_to :fpclass
	belongs_to :passport
	belongs_to :center

	def tell_partner
		SmsService.new(phone_number, "One customer registered just now for class #{self.fpclass.name} on #{self.expired_at} ").send_sms
	end

	def phone_number
		fpclass.partner.user.phone || "0000000000"
	end
end
