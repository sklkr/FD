class RenamePhotoGidToPhotoUid < ActiveRecord::Migration
  def change
  	rename_column :instructors, :photo_gid, :photo_uid
  end
end
