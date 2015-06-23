class Coupon < ActiveRecord::Base
	has_many :orders

	validates :code,          :presence => true
	validates :expires_at,    :presence => true

	COUPON_TYPES = ['CouponPercent', 'CouponValue','CouponFirstPurchasePercent', 'CouponFirstPurchaseValue']

	def value(item_prices, order)
	  qualified?(item_prices, order) ? coupon_amount(item_prices) : 0.0
	end

	def eligible?(order, at = nil)
	  at ||= order.updated_at || Time.zone.now
	  starts_at <= at && expires_at >= at
	end

end
