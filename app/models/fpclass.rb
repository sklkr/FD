class Fpclass < ActiveRecord::Base
extend FriendlyId

  LEVELS = ["Beginner", "Advanced", "All"]

  after_create :build_ice_cube_params
  default_scope { where('expiry<=?', Time.now) }
  scope :expired, -> { unscoped.where('expiry<?', Time.now) }

  belongs_to :instructor
  has_and_belongs_to_many :centers
  belongs_to :partner
  has_many :recursivedates
  has_many :clasbkings

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
      [date]
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
 		 search_dates.each do |date|
      recursivedates << Recursivedate.create(:ondate => date)
     end
 	end
end
