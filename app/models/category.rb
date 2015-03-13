class Category < ActiveRecord::Base
extend FriendlyId
	has_and_belongs_to_many :centerinfos
	has_many :instructors
	has_many :services
	friendly_id :name

	def cat_ids
		
	end
end
