class Center < ActiveRecord::Base
extend FriendlyId
	# Associations
	belongs_to :partner
	has_one :centerinfo
	has_one :verification
	has_one :accountinfo
	has_many :instructors
	has_many :services
	belongs_to :city
	belongs_to :area

	# Validations
	validates :name, :presence => true

	friendly_id :name, use: :slugged
	ratyrate_rateable "speed", "engine", "price"

	def should_generate_new_friendly_id?
	  new_record? || slug.blank?
	end
end
