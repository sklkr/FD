class AddOrderTypeToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :order_type, :string, :default => 'Service'
  end
end
