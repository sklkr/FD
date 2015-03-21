class Centerinfo < ActiveRecord::Base
	belongs_to :centertype
	belongs_to :center
	belongs_to :hour
	attachment :image
    has_and_belongs_to_many :categories
    has_and_belongs_to_many :experiences
    accepts_nested_attributes_for :center
    accepts_nested_attributes_for :hour

    def cat_list
    	unless center.nil?
    		categories
    	else
    		[]
    	end
    end
    def exp_list
        unless center.nil?
            experiences
        else
            []
        end
    end

    def fp_verified?
        unless self.fp_verified.nil?
            true
        else
            false
        end
    end

end
