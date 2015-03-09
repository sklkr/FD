class Instructor < ActiveRecord::Base
	belongs_to :category	
	belongs_to :center
	attachment :photo
end
