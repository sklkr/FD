class Fpclass < ActiveRecord::Base
extend FriendlyId

  LEVELS = ["Beginner", "Advanced", "All"]
  TS = ["06:00", "06:30", "07:00", "07:30", "08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30", "21:00", "21:30", "22:00"]
  # before_create :build_ice_cube_params
  default_scope { where('expiry >=?', Time.zone.now).order('start_time') }
  scope :expired, -> { unscoped.where('expiry<?', Time.now) }
  scope :any_classes, -> (date){ where('rcdates && ARRAY[?]', date) }
  # scope :all_tags, -> (tags){where('tags @> ARRAY[?]', tags)}

  belongs_to :instructor
  has_and_belongs_to_many :centers
  belongs_to :partner
  has_many :recursivedates, dependent: :destroy
  has_many :clasbkings

  validates_presence_of :centers
  validates_presence_of :name
  validates_presence_of :timings
  validates_presence_of :duration
  validates_presence_of :expiry
  validates_presence_of :date
  validates_presence_of :seats
  validates_presence_of :description
  
  def total_clasbkings
  	clasbkings.count
  end

  def remaining_seats
  	return 0 if self.seats.nil?
  	self.seats - total_clasbkings 
  end
 
  def search_dates
    if self.recurring
      FpCube.new(self).between_dates
    else
      [date.to_s]
    end
  end 

  friendly_id :name, use: :slugged
    # Checker for slugs and geneartion of slugs for older columns
    # Methodname.each(&:save)
  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end

  # Ransack attributes whitelisting
  def self.ransackable_attributes(auth_object = nil)
    super + ['search_date'] 
  end
  

 private
 	
 	# def build_ice_cube_params
 	# 	 search_dates.collect do |date|
  #     date
  #    end
 	# end
end
