class Centerinfo < ActiveRecord::Base
	belongs_to :centertype
	acts_as_taggable
end
