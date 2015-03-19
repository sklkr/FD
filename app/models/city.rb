class City < ActiveRecord::Base
	has_many :centers
	has_many :areas
end
