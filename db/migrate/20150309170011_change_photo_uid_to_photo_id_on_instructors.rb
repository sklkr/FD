class ChangePhotoUidToPhotoIdOnInstructors < ActiveRecord::Migration
  def change
  	rename_column :instructors, :photo_uid, :photo_id
  	change_column :instructors, :photo_id, :string
  end
end
