class RenameCityToCityIdOnAccountinfos < ActiveRecord::Migration
  def change
  	remove_column :accountinfos, :city
  	add_column :centers, :city_id, :integer 
  end
end
