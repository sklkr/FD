class RenameBrandPhotoGid < ActiveRecord::Migration
  def change
  	rename_column :centerinfos, :brand_photo_gid, :brand_photo_uid
  end
end
