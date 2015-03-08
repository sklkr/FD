class AddCenterIdToCenterinfo < ActiveRecord::Migration
  def change
    add_column :centerinfos, :center_id, :integer
  end
end
