class Centerinfo < ActiveRecord::Base
	belongs_to :centertype
	belongs_to :center
	has_one :hour
	acts_as_taggable
	dragonfly_accessor :brand_photo
    accepts_nested_attributes_for :center
end
