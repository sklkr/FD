class RenameImageId < ActiveRecord::Migration
  def change
  	change_column :centerinfos, :image_id, :string
  end
end
