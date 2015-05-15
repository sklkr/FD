class Fpclass < ActiveRecord::Base
extend FriendlyId

  LEVELS = ["Beginner", "Advanced", "All"]

  before_create :build_ice_cube_params

  belongs_to :instructor
  has_and_belongs_to_many :centers
  belongs_to :partner
  has_many :clasbkings

  def total_clasbkings
  	clasbkings.count
  end

  def remaining_seats
  	return 0 if self.seats.nil?
  	self.seats - total_clasbkings 
  end
 
  def search_date
    if self.recurring
      FpCube.new(self).between_dates
    else
      return [self.date] if self.date == asked_date
      []
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
 	
 	def build_ice_cube_params
 		return if self.type_of.blank?
 		data = ActiveSupport::JSON.decode(self.type_of)
 		self.interval = data["interval"]
 		self.rule_type = data["rule_type"]
 		self.week_start = data["week_start"]
 	end
end
