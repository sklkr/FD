class Passport < ActiveRecord::Base
  TYPE = {
    'passport_alpha' => {'quantity' => '1', 'unit_price' => '1500', :tickets => '20', :order_type => 'Package', :end_date => Date.today + 30.days},
    'passport_beta' => {'quantity' => '1', 'unit_price' => '999', :tickets => '10', :order_type => 'Package', :end_date => Date.today + 30.days}
  }

  delegate :full_name, :email, to: :customer, :allow_nil => true

  ACTIVE = 'passport_beta'

  belongs_to :order_item
  belongs_to :customer
  has_many :clasbkings
  
  scope :recent, -> { order(:created_at) }

  def total_clasbkings
  	Clasbking.unscoped.where("passport_id=?",id).count || 0
  end

  def total_active_clasbkings
  	clasbkings.count
  end

  def remaining_tickets
  	total_tickets - total_clasbkings 
  end

  def total_tickets
    tickets.nil? ? 0 : tickets
  end

  def order_id
  	"P00#{(self.id + 426).to_s.rjust(3,'0')}"
  end  
end
