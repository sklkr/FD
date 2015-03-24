class Category < ActiveRecord::Base
extend FriendlyId
	# Associations
	has_and_belongs_to_many :centerinfos
	has_many :instructors
	has_many :services

	# Scopes 
	friendly_id :name, use: :slugged

	def cat_ids
		
	end

	# Checker for slugs and geneartion of slugs for older columns
	# Methodname.each(&:save)
	def should_generate_new_friendly_id?
	  new_record? || slug.blank?
	end
end
