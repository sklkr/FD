class Fpclass < ActiveRecord::Base
extend FriendlyId

  LEVELS = ["Beginner", "Advanced", "All"]
  TS = ["06:00","06:15","06:30","06:45","07:00","07:15","07:30","07:45","08:00","08:15","08:30","08:45","09:00","09:15","09:30","09:45","10:00","10:15","10:30","10:45","11:00","11:15","11:30","11:45","12:00","12:15","12:30","12:45","13:00","13:15","13:30","13:45","14:00","14:15","14:30","14:45","15:00","15:15","15:30","15:45","16:00","16:15","16:30","16:45","17:00","17:15","17:30","17:45","18:00","18:15","18:30","18:45","19:00","19:15","19:30","19:45","20:00","20:15","20:30","20:45","21:00","21:15","21:30","21:45","22:00","22:15"]
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
