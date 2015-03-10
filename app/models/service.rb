class Service < ActiveRecord::Base
 belongs_to :center
 belongs_to :category

 def percent
 	(self.selling_price/self.original_price)*100
 end
end
