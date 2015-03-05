class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :customer_id
      t.integer :service_id
      t.float :rate
      t.text :comment

      t.timestamps
    end
  end
end
