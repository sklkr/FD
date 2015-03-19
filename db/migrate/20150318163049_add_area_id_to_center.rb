class AddAreaIdToCenter < ActiveRecord::Migration
  def change
    add_column :centers, :area_id, :integer
  end
end
