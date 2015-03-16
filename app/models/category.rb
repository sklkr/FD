class Category < ActiveRecord::Base
CAT = { 1 => 'yoga', 2 => 'gym', 3 => 'meditation', 4 => 'spa', 5 => 'swimming', 6 => 'adventure',7 => 'consultant', 8 => 'kids' }
extend FriendlyId
	has_and_belongs_to_many :centerinfos
	has_many :instructors
	has_many :services
	friendly_id :name
 	scope :find_lazy, ->(id) { where(:id => CAT.key(id)).first}

	def cat_ids
		
	end
end
