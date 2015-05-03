class Accountinfo < ActiveRecord::Base
	belongs_to :center
	belongs_to :brand
	
	# Validations
	validates :personname, presence: true
	# validates :mobile, :numericality => true, length: { in: 10..11 }
	


	def brandname
		unless self.brand.nil?
		 self.brand.name
		else
			nil
		end
	end

	def brandname=(name)
		self.brand_id = (Brand.find_by_name(name) || Brand.create(:name => name)).id
	end
end
