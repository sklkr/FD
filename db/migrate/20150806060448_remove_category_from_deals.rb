class RemoveCategoryFromDeals < ActiveRecord::Migration
  def change
    remove_column :deals, :category, :string
    add_column :deals, :category, :string
  end
end
