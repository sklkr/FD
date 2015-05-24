class ChangeStartTimeToTime < ActiveRecord::Migration
  def change
  	remove_column :fpclasses, :start_time
  end
end
