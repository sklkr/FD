class OrderItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :service
	belongs_to :passport
	belongs_to :deal

	scope :services, -> { where('order_type=?', 'Service')}
	scope :deals, -> { where('order_type=?', 'Deal')}
	
    validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
