class Service < ActiveRecord::Base
 belongs_to :center
 belongs_to :category
 scope :regular, -> { where(service_type: '1') }
 scope :upcoming, -> { where(service_type: '2') }


 def percent
 	((1-(self.selling_price/self.original_price))*100).to_i
 end
end
