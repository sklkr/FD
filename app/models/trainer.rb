class Trainer < ActiveRecord::Base
	include NumberGenerator # Used as global to generate random number with perfix overwrite with generate nubmer method below

	validates_presence_of :name
	validates_presence_of :location
	validates_presence_of :email
	validates_presence_of :service
	validates_presence_of :phone
	validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, :message => "Email not valid"

	before_validation :generate_number
	after_save :send_mail


	def send_mail
		TrainerMailer.inform_admin(self).delay.deliver
		TrainerMailer.inform_customer(self).delay.deliver
		SmsService.new(phone, "Dear #{self.name}, Thank you for your order. Your Ticket ID is #{self.number}. One of our experts will attend to your request soon.").delay.send_sms
	end

	def generate_number(options = {})
     options[:prefix] ||= 'T'
     super(options)
    end
end
