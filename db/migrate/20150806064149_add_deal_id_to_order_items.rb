class AddDealIdToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :deal_id, :integer
  end
end
