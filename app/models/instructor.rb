class Instructor < ActiveRecord::Base
	belongs_to :category	
	dragonfly_accessor :photo
end
