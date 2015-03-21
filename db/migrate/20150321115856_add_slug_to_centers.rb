class AddSlugToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :slug, :string
    add_index :centers, :slug, unique: true
  end
end
