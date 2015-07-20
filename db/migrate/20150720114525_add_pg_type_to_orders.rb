class AddPgTypeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :pg_type, :string
  end
end
