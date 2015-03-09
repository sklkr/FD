class Center < ActiveRecord::Base
	belongs_to :partner
	has_one :centerinfo
	has_one :accountinfo
	has_many :instructors
	has_many :services
	has_and_belongs_to_many :categories
	extend FriendlyId
	friendly_id :name
	
end
