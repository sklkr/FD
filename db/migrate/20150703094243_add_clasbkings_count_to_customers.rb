class AddClasbkingsCountToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :clasbkings_count, :integer
  end
end
