class AddStatusToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :status, :string, :default => "inactive"
  end
end
