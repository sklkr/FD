class Centertype < ActiveRecord::Base
	has_one :user
	has_many :centerinfos

	# Validations
	
end
