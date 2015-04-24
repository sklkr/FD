class Cphoto < ActiveRecord::Base
	attachment :image
	belongs_to :center
end
