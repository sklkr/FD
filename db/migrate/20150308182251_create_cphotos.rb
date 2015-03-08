class CreateCphotos < ActiveRecord::Migration
  def change
    create_table :cphotos do |t|
      t.string :image_uid
      t.integer :centerinfo_id

      t.timestamps
    end
  end
end
