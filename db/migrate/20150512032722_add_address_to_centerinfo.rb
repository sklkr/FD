class AddAddressToCenterinfo < ActiveRecord::Migration
  def change
    add_column :centerinfos, :address, :string
  end
end
