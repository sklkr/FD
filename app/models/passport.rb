class Passport < ActiveRecord::Base
  belongs_to :order_item
  belongs_to :customer
  has_many :clasbkings


  def total_clasbkings
  	clasbkings.unscoped.count
  end

  def total_active_clasbkings
  	clasbkings.count
  end

  def remaining_tickets
  	self.tickets - total_clasbkings 
  end

  def order_id
  	"P00#{(self.id + 426).to_s.rjust(3,'0')}"
  end
end
