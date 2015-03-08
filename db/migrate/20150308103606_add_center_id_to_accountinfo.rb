class AddCenterIdToAccountinfo < ActiveRecord::Migration
  def change
    add_column :accountinfos, :center_id, :integer
  end
end
