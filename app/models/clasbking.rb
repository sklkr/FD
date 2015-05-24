class Clasbking < ActiveRecord::Base
    default_scope  { where('expired_at >= ?', Time.now) }

	belongs_to :customer
	belongs_to :fpclass
	belongs_to :passport
	belongs_to :center
end
