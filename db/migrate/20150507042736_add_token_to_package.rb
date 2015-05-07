class AddTokenToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :token, :string
  end
end
