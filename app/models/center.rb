class Center < ActiveRecord::Base
extend FriendlyId
  default_scope { where(status: 'active') }

	# Associations
	belongs_to :partner
	has_one :centerinfo, :dependent => :destroy
	has_one :verification, :dependent => :destroy
	has_one :accountinfo, :dependent => :destroy
	has_one :commission, :dependent => :destroy
	has_many :instructors, :dependent => :destroy
	has_many :services, :dependent => :destroy
	has_many :centermen, :dependent => :destroy
	has_many :bookings, :dependent => :destroy
	belongs_to :city
	belongs_to :area

	# Validations
	validates :name, :presence => true
	validates :partner_id, :presence => true

	friendly_id :name, use: :slugged
	ratyrate_rateable "speed", "engine", "price"
    
    # Checker for slugs and geneartion of slugs for older columns
    # Methodname.each(&:save)
	def should_generate_new_friendly_id?
	  new_record? || slug.blank?
	  
	end
end
