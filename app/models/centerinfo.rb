class Centerinfo < ActiveRecord::Base
	belongs_to :centertype
	belongs_to :center
	belongs_to :hour
	acts_as_taggable
	dragonfly_accessor :image
    accepts_nested_attributes_for :center
    accepts_nested_attributes_for :hour

    def cat_list
    	unless center.nil?
    		center.categories
    	else
    		[]
    	end
    end
end
