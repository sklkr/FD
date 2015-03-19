class Service < ActiveRecord::Base
CAT = { 1 => 'yoga', 2 => 'gym', 3 => 'meditation', 4 => 'spa', 5 => 'swimming', 6 => 'adventure',7 => 'consultant', 8 => 'kids' }
extend FriendlyId

#associations 
 belongs_to :center
 belongs_to :category
 has_many :bookings
 has_and_belongs_to_many :instructors, :join_table => 'services_instructors'
 
 #scopes
 scope :regular, -> { where(service_type: '1') }
 scope :upcoming, -> { where(service_type: '2') }
 friendly_id :name


 def percent
 	((1-(self.selling_price/self.original_price))*100).to_i
 end
 def duration
 	self.end_date
 end
 def status
 	if self.start_date.nil? || self.start_date < Time.now
 		"Expired"
 	else
 		"Booked"
 	end
 end
 
 def start_date_format
 	self.start_date.strftime('%d %b %Y')
 end

 def find_lazy
 	CAT[self.category_id]
 end

 def expired
 	Time.zone.now + self.expired_on.day
 end
end
