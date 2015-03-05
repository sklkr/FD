class AddBusinessNameToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :business_name, :string
    add_column :partners, :category_id, :integer
  end
end
