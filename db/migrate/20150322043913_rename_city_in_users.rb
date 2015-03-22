class RenameCityInUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :city
  	remove_column :users, :area
  	add_column :users, :city_id, :integer
  	add_column :users, :area_id, :integer
  end
end
