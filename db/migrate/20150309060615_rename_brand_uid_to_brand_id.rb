class RenameBrandUidToBrandId < ActiveRecord::Migration
  def change
  	rename_column :centerinfos, :brand_photo_uid, :image_uid
  end
end
