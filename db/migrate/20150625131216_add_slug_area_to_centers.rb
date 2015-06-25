class AddSlugAreaToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :slug_area, :string
  end
end
