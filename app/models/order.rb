class Order < ActiveRecord::Base
   include NumberGenerator # Used as global to generate random number with perfix overwrite with generate nubmer method below
   # include AASM # For state maintaining
   extend FriendlyId
   friendly_id :number

   def generate_number(options = {})
     options[:prefix] ||= 'O'
     super(options)
   end

   before_validation { self.token = SecureRandom.uuid  if self.token.blank? }

   has_many :order_items, :dependent => :destroy
   has_many :invoices
   has_many :completed_invoices,   -> { completed },  class_name: 'Invoice'
   has_many :authorized_invoices,  -> { authorized }, class_name: 'Invoice'
   has_many :paid_invoices,  -> { paid }, class_name: 'Invoice'
   has_many :canceled_invoices, ->  { canceled }, class_name: 'Invoice'
   belongs_to :customer
   has_one :service_order_item, -> { services }, class_name: "OrderItem"


   scope :success, -> { where('status=?','success')}

   belongs_to :coupon

   # validates :email_address, presence: true, format: { with: CustomValidators::Emails.email_validator }

   accepts_nested_attributes_for :order_items


   def status
     return 'success' if super == 'success'
     return 'not processed' if invoices.empty?
     invoices.last.state
   end

   # Is this order empty? (i.e. doesn't have any items associated with it)
   #
   # @return [Boolean]
   def empty?
     order_items.empty?
   end

   # Does this order have items?
   #
   # @return [Boolean]
   def has_items?
     total_items > 0
   end

   # Return the number of items in the order?
   #
   # @return [Integer]
   def total_items
     order_items.inject(0) { |t,i| t + i.quantity }
   end

   def total_amount
     total_items_amount.to_i - discount
   end

   def total_items_amount
    order_items.inject(0) { |t,i| t + i.unit_price }
   end

   def discount
     coupon.blank? ? 0 : coupon.amount.to_i
   end
end
