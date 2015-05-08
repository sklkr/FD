class OrderItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :service
	belongs_to :passport
	
    validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
