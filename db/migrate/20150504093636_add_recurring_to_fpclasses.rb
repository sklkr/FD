class AddRecurringToFpclasses < ActiveRecord::Migration
  def change
    add_column :fpclasses, :recurring, :boolean, default: false
  end
end
