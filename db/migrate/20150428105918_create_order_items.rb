class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :quantity
      t.decimal :unit_price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
