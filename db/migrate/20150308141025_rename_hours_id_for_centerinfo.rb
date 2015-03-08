class RenameHoursIdForCenterinfo < ActiveRecord::Migration
  def change
  	rename_column :centerinfos, :hours_id, :hour_id
  end
end
