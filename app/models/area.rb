class Area < ActiveRecord::Base
	has_many :centers
	belongs_to :city
end
