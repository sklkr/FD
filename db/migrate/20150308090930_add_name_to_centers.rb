class AddNameToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :name, :string
  end
end
