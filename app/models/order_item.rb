class OrderItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :service

	validates :quantity, :numericality => true
	validates :service, :presence => true
end
