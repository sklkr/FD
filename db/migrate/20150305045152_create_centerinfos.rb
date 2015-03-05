class CreateCenterinfos < ActiveRecord::Migration
  def change
    create_table :centerinfos do |t|
      t.string :name
      t.string :website
      t.integer :brand_photo_gid
      t.integer :center_photo_gid
      t.boolean :fp_verified
      t.string :center_type
      t.integer :hours_id
      t.integer :slots
      t.text :brief_desc
      t.text :detailed_desc
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
