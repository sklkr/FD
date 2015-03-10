class RenameImageUidToImageIdOnCphoto < ActiveRecord::Migration
  def change
	rename_column :cphotos, :image_uid, :image_id  	
  end
end
