class AddDaysToServices < ActiveRecord::Migration
  def change
    add_column :services, :days, :integer
  end
end
