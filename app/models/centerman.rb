class Centerman < ActiveRecord::Base
	belongs_to :user
	belongs_to :center
	attachment :photo
end
