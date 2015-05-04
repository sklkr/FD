class AddIntervalToFpclass < ActiveRecord::Migration
  def change
    add_column :fpclasses, :interval, :integer
    add_column :fpclasses, :rule_type, :string
    add_column :fpclasses, :week_start, :integer
  end
end
