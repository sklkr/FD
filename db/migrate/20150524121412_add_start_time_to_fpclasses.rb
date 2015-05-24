class AddStartTimeToFpclasses < ActiveRecord::Migration
  def change
    add_column :fpclasses, :start_time, :time
  end
end
