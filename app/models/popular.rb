class Popular < ActiveRecord::Base
  belongs_to :center
  belongs_to :partner
  belongs_to :category

  before_create :append_partner



  private
  	def append_partner
  		self.partner = self.center.partner
  	end
end
