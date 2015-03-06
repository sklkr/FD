class AddCentertypeIdToCenterInfos < ActiveRecord::Migration
  def change
    add_column :centerinfos, :centertype_id, :integer
  end
end
