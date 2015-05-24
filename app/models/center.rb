class Center < ActiveRecord::Base
extend FriendlyId
acts_as_commontable

  CENTERTYPES = ["Gym", "Yoga", "Dance", "Swim", "Aerobics", "Zumba", "Pillatees", "Martial Art", "Boxing", "Strength training", "Spa & Saloon"]
  
  TRAINERTYPES = ["Aerobics", "Choreographer", "Martial Arts", "Dietician", "Physical Trainer", "Phsiotherapist", "Yoga", "Zumba", ]

  default_scope { where(status: 'active') }
  scope :pending, -> { unscoped.where('status!=?', 'active')}
  before_save { self.place_name && self.place_id = GPlaces.new(self.place_name).get_id }   # To get place id from place name
  
	attachment :image
	
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
	has_many :cphotos, :dependent => :destroy
	has_many :clasbkings
	belongs_to :city
	belongs_to :area
	has_one :popular, :dependent => :destroy
	
	accepts_nested_attributes_for :centerinfo
	accepts_nested_attributes_for :accountinfo
    
	has_and_belongs_to_many :experiences
	has_and_belongs_to_many :facilities
	has_and_belongs_to_many :fpclasses, :dependent => :destroy

	# Validations
	validates :name, :presence => true

	friendly_id :name, use: :slugged
	ratyrate_rateable "speed", "engine", "price"
    
    # Checker for slugs and geneartion of slugs for older columns
    # Methodname.each(&:save)
	def should_generate_new_friendly_id?
	  new_record? || slug.blank?
	end
end
