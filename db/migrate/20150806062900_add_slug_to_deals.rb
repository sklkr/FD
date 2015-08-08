class AddSlugToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :slug, :string, unique: true
  end
end
