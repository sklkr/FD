class Fpclass < ActiveRecord::Base
  before_create :build_ice_cube_params

  belongs_to :instructor
  has_and_belongs_to_many :centers
  belongs_to :partner

 private
 	
 	def build_ice_cube_params
 		return if self.type_of.blank?
 		data = ActiveSupport::JSON.decode(self.type_of)
 		self.interval = data["interval"]
 		self.rule_type = data["rule_type"]
 		self.week_start = data["week_start"]
 	end
end
