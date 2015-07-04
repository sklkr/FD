class Clasbking < ActiveRecord::Base
  default_scope  { where('expired_at >= ?', Time.now) }
  after_create :notify
  before_destroy :notify_cancel

	belongs_to :customer, counter_cache: true
	belongs_to :fpclass
	belongs_to :passport
	belongs_to :center

  scope :recent, -> { order(:created_at) }
  
  def notify
    tell_customer
    tell_partner
    tell_admin
  end

  def notify_cancel
    tell_customer_cancel
    tell_partner_cancel
    tell_admin_cancel
  end

  def tell_partner
    RegistrationMailer.partner_notify(self).delay.deliver
    SmsService.new(phone_number, "#{self.customer.user.full_name} has registered #{self.fpclass.name} on #{self.expired_at} at #{self.expired_humanize}. @FitnessPapa").delay.send_sms
	end

  def tell_partner_cancel
    RegistrationMailer.partner_cancel(self).delay.deliver
    # SmsService.new(phone_number, "#{self.customer.user.full_name} has registered #{self.fpclass.name} on #{self.expired_at} at #{self.expired_humanize}. @FitnessPapa").delay.send_sms
  end

  def tell_customer
    RegistrationMailer.customer_notify(self).delay.deliver
    SmsService.new(customer.user.phone, "Registration for #{self.fpclass.name} at #{self.center.name} on #{self.expired_at} at #{self.expired_humanize} is confirmed successfully.").delay.send_sms
  end

  def tell_customer_cancel
    RegistrationMailer.customer_cancel(self).delay.deliver
    # SmsService.new(customer.user.phone, "Registration for #{self.fpclass.name} at #{self.center.name} on #{self.expired_at} at #{self.expired_humanize} is confirmed successfully.").delay.send_sms
  end

  def tell_admin
    RegistrationMailer.admin_notify(self).delay.deliver
  end

  def tell_admin_cancel
    RegistrationMailer.admin_cancel(self).delay.deliver
  end

	def phone_number
		fpclass.centers.first.mobile || "0000000000"
	end

  def expired
    where('expired_at < ?', Time.now)
  end

  def expired_humanize
    self.expired_at && self.expired_at.strftime('%B %d %H:%M')
  end
end
