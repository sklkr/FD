class AddPricetagToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :pricetag, :string
  end
end
