class Superadmin < ActiveRecord::Base
	belongs_to :user

	# Validations
	validates :email, :presence => true
	validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, :message => "Email not valid"
end
