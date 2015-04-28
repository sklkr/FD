class AddServiceIdToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :service_id, :integer
    add_column :order_items, :center_id, :integer
  end
end
