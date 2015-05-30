class Clasbking < ActiveRecord::Base
  default_scope  { where('expired_at >= ?', Time.now) }
  after_create :sms_notify
  after_create :tell_admin

	belongs_to :customer
	belongs_to :fpclass
	belongs_to :passport
	belongs_to :center

  def sms_notify
    tell_customer
    tell_partner
  end

  def tell_partner
    SmsService.new(phone_number, "#{self.customer.user.full_name} has registered #{self.fpclass.name} on #{self.expired_at} at #{self.fpclass.start_time.strftime('%H:%M')}.").delay.send_sms
	end

  def tell_customer
    SmsService.new(customer.user.phone, "Registration for #{self.fpclass.name} at #{self.center.name} on #{self.expired_at} at #{self.fpclass.start_time.strftime('%H:%M')} is confirmed successfully.").delay.send_sms
  end


  def tell_admin
    RegistrationMailer.admin_notify(self).delay.deliver
  end

	def phone_number
		fpclass.partner.user.phone || "0000000000"
	end
end
