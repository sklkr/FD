class Instructor < ActiveRecord::Base
	belongs_to :category	
	belongs_to :center
    has_and_belongs_to_many :services, :join_table => 'services_instructors'

	attachment :photo
end
