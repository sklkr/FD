class RemoveRecurringFromFpclasses < ActiveRecord::Migration
  def change
    remove_column :fpclasses, :recurring, :boolean
    add_column :fpclasses, :recurring, :json
  end
end
