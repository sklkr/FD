class AddDurationToServices < ActiveRecord::Migration
  def change
    add_column :services, :duration, :integer
  end
end
