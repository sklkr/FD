class Invoice < ActiveRecord::Base
  include AASM
  include NumberGenerator # Used as global to generate random number with perfix overwrite with generate nubmer method below

  def generate_number(options = {})
    options[:prefix] ||= 'IN'
    super(options)
  end

  belongs_to :order
  
  validates :amount,        :presence => true
  validates :invoice_type,  :presence => true

  PURCHASE  = 'Purchase'
  INVOICE_TYPES = [PURCHASE]

  aasm column: :state do
    state :pending, initial: true
    state :authorized
    state :paid
    state :payment_declined
    state :canceled
    state :refunded

    #after_transition :on => 'cancel', :do => :cancel_authorized_payment
	event :payment_captured do
      transitions from: :authorized, to: :paid
    end
	event :transaction_declined do
      transitions from:  :pending,
                  to:    :payment_declined
      transitions from:  :payment_declined,
                  to:    :payment_declined
      transitions from:  :authorized,
                  to:    :authorized
    end
	event :cancel do
      transitions from: :authorized, to: :canceled
    end
  end


end
