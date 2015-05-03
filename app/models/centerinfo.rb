class Centerinfo < ActiveRecord::Base
	belongs_to :centertype
	belongs_to :center
	belongs_to :hour
	has_and_belongs_to_many :categories
    accepts_nested_attributes_for :hour

    # Validations
    validates :detailed_desc, presence: true


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
