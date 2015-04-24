class AddCenterIdToCphotos < ActiveRecord::Migration
  def change
    add_column :cphotos, :center_id, :integer
  end
end
