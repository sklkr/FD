class Instructor < ActiveRecord::Base
	belongs_to :category	
	belongs_to :center
	dragonfly_accessor :photo
end
