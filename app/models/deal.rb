class Deal < ActiveRecord::Base
 CATEGORY = ["Zumba","Pilates","Gym ","Martial Arts & Kick Boxing","Healthy Food & Beverages","Kids Fitness","Celebrity Trainers","Fitness Studio","Yoga","Cross Functional Training","Dance","Workout Sessions","Bootcamp"]
 SUBCATEGORY = ['Beverages', 'Dessert', 'Snacks', 'Packages']

 attachment :image
end
