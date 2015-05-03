class Instructor < ActiveRecord::Base
    default_scope  { order(:created_at => :desc) }

	belongs_to :category	
	belongs_to :center
	belongs_to :partner
    has_and_belongs_to_many :services, :join_table => 'services_instructors'

	attachment :photo
end
