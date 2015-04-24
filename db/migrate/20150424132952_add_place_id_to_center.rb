class AddPlaceIdToCenter < ActiveRecord::Migration
  def change
    add_column :centers, :place_id, :string
    add_column :centers, :place_name, :string
  end
end
