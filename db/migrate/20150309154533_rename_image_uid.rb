class RenameImageUid < ActiveRecord::Migration
  def change
  	rename_column :centerinfos, :image_uid, :image_id
  end
end
