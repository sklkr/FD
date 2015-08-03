class Service < ActiveRecord::Base
CAT = { 1 => 'yoga', 2 => 'gym', 3 => 'meditation', 4 => 'spa', 5 => 'swimming', 6 => 'adventure',7 => 'consultant', 8 => 'kids' }
GENDER = {'All' => 1, 'Unisex' => 2 , 'Male' => 3 ,'Female' => 4,'Kids' => 5}

extend FriendlyId
#associations 
 belongs_to :center
 belongs_to :category
 has_many :bookings
 has_and_belongs_to_many :instructors, :join_table => 'services_instructors'
 has_many :order_items
 #scopes
 scope :regular, -> { where(service_type: '1') }
 scope :upcoming, -> { where(service_type: '2') }

 friendly_id :name, use: :slugged

 # validations
 
 #askers 
 def is_pass?
 	if [2,5].include?(self.category_id) && self.service_type == '1'
 		return true
 	else
 		return false
 	end
 end


 def percent
 	if self.selling_price != 0 || self.original_price != 0
 		return ((1-(self.selling_price/self.original_price))*100).to_i
 	end
 	0
 end
 # def duration
 # 	self.end_date
 # end
 def status
 	if self.start_date.nil? || self.start_date < Time.now
 		"Expired"
 	else
 		"Booked"
 	end
 end
 
 def start_date_format
 	self.start_date.strftime('%d %b %Y')
 end

 def find_lazy
 	CAT[self.category_id]
 end

 def expired
 	Time.zone.now + self.expired_on.day
 end

 def gender
 	GENDER[self.gender_id]
 end

 def should_generate_new_friendly_id?
  new_record? || slug.blank?
 end

 def receipt(order)
 	 customer = order.customer

	 Receipts::Receipt.new(
	   id: order.number,
	   product: "FitnessPapa",
	   company: {
	     name: "FitnessPapa",
	     address: "Place on Earth Tech Park,L2/3, 2nd main, Pai Layout, Old Madras Road, Bangalore",
	     email: "support@fitnesspapa.com",
	     logo: Rails.root.join("app/assets/images/fp_logo.jpg")
	   },
	   line_items: [
	     ["Date",           order.updated_at.strftime('%d-%m-%Y')],
	     ["Account Billed", "#{customer.full_name} (#{customer.email})"],
	     ["Product",        "#{self.center.name.capitalize} - #{self.name}"],
	     ["Amount",         "Rs. #{order.order_items.last.unit_price}"],
	     ["Charged to",     "#{order.pg_type} (#{order.cardnum})"]
	   ]
	 )
  end
end
