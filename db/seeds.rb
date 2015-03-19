# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
['Yoga', 'Gym', 'Meditation', 'Spa & Saloon', 'Swimming', 'Adventure', 'Consultant', 'Kids zone'].each do |name|
	Category.find_or_create_by(:name => name)
end

['All', 'Both Male & Female', 'Male', 'Female', 'Kids'].each do |c|
	Centertype.find_or_create_by(:name => c)
end

["Two Wheeler", "Four Wheeler", "Air Conditioning", "Rest Room", "Locker", "Change Room", "Wifi", "Shower", "Swimming Pool", "Kids Play Area", "Steam & Sauna"].each do |name|
	Experience.find_or_create_by(:name => name)
end


Superadmin.create(:email => 'sid@mail.com',:user_id => User.create(:password => 'password').id )

['Ahmedabad','Bangalore','Chandigarh','Chennai','Coimbatore','Delhi','Kochi','Kolkata','Lucknow','Noida', 'Goa', 'Gurgaon','Hyderabad','Jaipur','Mumbai','Pune','Trivandrum'].each do |cname|
	City.create(:name => cname)
end