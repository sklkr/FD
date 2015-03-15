class Service < ActiveRecord::Base
extend FriendlyId
 belongs_to :center
 belongs_to :category
 scope :regular, -> { where(service_type: '1') }
 scope :upcoming, -> { where(service_type: '2') }
 friendly_id :name
 has_many :bookings


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
 
end
