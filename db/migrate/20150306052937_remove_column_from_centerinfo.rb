class RemoveColumnFromCenterinfo < ActiveRecord::Migration
  def change
  	remove_column :centerinfos, :center_type 
  end
end