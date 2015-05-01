class Order < ActiveRecord::Base
   
   # Used as global to generate random number with perfix overwrite with generate nubmer method below
   include NumberGenerator
  
   def generate_number(options = {})
     options[:prefix] ||= 'O'
     super(options)
   end

   before_validation { self.token = SecureRandom.uuid  if self.token.blank? }

   has_many :order_items, :dependent => :destroy
   accepts_nested_attributes_for :order_items


   # Order Number
   def number
     id ? id.to_s.rjust(6, '0') : nil
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
    order_items.inject(0) { |t,i| t + i.unit_price }
   end

end
