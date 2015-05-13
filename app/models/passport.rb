class Passport < ActiveRecord::Base
  belongs_to :order_item
  belongs_to :customer
  has_many :clasbkings


  def total_clasbkings
  	clasbkings.count
  end

  def remaining_tickets
  	self.tickets - total_clasbkings 
  end
end
