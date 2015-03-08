class Accountinfo < ActiveRecord::Base
	belongs_to :center
	belongs_to :brand

	def brandname
		self.brand.name
	end
	def brandname=(name)
		self.brand_id = (Brand.find_by_name(name) || Brand.create(name)).id
	end
end
