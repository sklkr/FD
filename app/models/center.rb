class Center < ActiveRecord::Base
extend FriendlyId
	belongs_to :partner
	has_one :centerinfo
	has_one :verification
	has_one :accountinfo
	has_many :instructors
	has_many :services
	belongs_to :city
	belongs_to :area
	friendly_id :name
	ratyrate_rateable "speed", "engine", "price"
end
