class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :service_id
      t.integer :customer_id
      t.integer :quantity
      t.float :price
      t.string :status

      t.timestamps
    end
  end
end
