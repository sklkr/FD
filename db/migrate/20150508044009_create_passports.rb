class CreatePassports < ActiveRecord::Migration
  def change
    create_table :passports do |t|
      t.date :start_date
      t.date :end_date
      t.references :order_item, index: true
      t.references :customer, index: true
      t.integer :tickets
      t.integer :active

      t.timestamps
    end
  end
end
