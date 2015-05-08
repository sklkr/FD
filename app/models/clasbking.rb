class Clasbking < ActiveRecord::Base
	belongs_to :customer
	belongs_to :fpclass
	belongs_to :passport
end
