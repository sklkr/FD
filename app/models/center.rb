class Center < ActiveRecord::Base
	belongs_to :partner
	has_one :centerinfo
	has_one :accountinfo
	has_many :instructors
	extend FriendlyId
	friendly_id :name
end
