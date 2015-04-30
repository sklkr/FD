class AddCenterTypeToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :center_type, :string
  end
end
