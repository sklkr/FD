class Deal < ActiveRecord::Base
 CATEGORY = ["Zumba","Pilates","Gym ","Martial Arts & Kick Boxing","Healthy Food & Beverages","Kids Fitness","Celebrity Trainers","Fitness Studio","Yoga","Cross Functional Training","Dance","Workout Sessions","Bootcamp"]
 SUBCATEGORY = ['Beverages', 'Dessert', 'Snacks', 'Packages']
 
 attachment :image
 extend FriendlyId
 friendly_id :name, use: :slugged

 validates :name, uniqueness: true

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
	     ["Product",        "#{self.name.capitalize}"],
	     ["Amount",         "Rs. #{order.total_amount}"],
	     ["Charged to",     "#{order.pg_type} (#{order.cardnum})"]
	   ]
	 )
	end
end
