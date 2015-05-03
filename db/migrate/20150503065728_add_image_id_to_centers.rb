class AddImageIdToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :image_id, :string
  end
end
