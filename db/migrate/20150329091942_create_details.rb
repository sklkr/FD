class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :gender
      t.string :name
      t.boolean :kid
      t.string :mobile
      t.text :request
      t.integer :booking_id

      t.timestamps
    end
  end
end
