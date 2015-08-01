class OrderItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :service
	belongs_to :passport

	scope :services, -> { where('order_type=?', 'Service')}
	
    validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
