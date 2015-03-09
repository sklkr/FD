class Category < ActiveRecord::Base
	has_and_belongs_to_many :centers
	has_many :instructors
	has_many :services
	def cat_ids
		
	end
end
