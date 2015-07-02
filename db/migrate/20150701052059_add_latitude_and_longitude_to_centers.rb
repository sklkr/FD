class AddLatitudeAndLongitudeToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :latitude, :float
    add_column :centers, :longitude, :float
  end
end
