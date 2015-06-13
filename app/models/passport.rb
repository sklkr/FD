class Passport < ActiveRecord::Base
  TYPE = {
    'passport_alpha' => {'quantity' => '1', 'unit_price' => '1500', :tickets => '20', :order_type => 'Package', :end_date => Date.today + 30.days},
    'passport_beta' => {'quantity' => '1', 'unit_price' => '199', :tickets => '3', :order_type => 'Package', :end_date => Date.today + 15.days}
  }

  ACTIVE = 'passport_beta'

  belongs_to :order_item
  belongs_to :customer
  has_many :clasbkings
  
  def total_clasbkings
  	Clasbking.unscoped.where("passport_id=?",id).count
  end

  def total_active_clasbkings
  	clasbkings.count
  end

  def remaining_tickets
  	tickets - total_clasbkings 
  end

  def order_id
  	"P00#{(self.id + 426).to_s.rjust(3,'0')}"
  end  
end
