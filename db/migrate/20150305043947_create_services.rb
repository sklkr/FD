class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer :center_id
      t.integer :category_id
      t.string :type
      t.string :name
      t.datetime :validity
      t.string :time_taken
      t.float :original_price
      t.float :selling_price
      t.integer :gender_id
      t.string :schedule
      t.datetime :expired_on
      t.datetime :start_date
      t.datetime :end_date
      t.integer :seats
      t.boolean :active
      t.text :service_desc

      t.timestamps
    end
  end
end
