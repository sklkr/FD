# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
['Yoga', 'Gym', 'Meditation', 'Spa & Saloon', 'Swimming', 'Fitness', 'Consultant', 'Kids zone'].each do |name|
	Category.create(:name => name)
end

['All', 'Both Male & Female', 'Male', 'Female', 'Kids'].each do |c|
	Centertype.create(:name => c)
end