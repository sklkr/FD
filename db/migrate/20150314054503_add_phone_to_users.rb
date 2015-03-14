class AddPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :emergency_name, :string
    add_column :users, :emergency_phone, :string
    add_column :users, :centertype_id, :integer
    add_column :users, :address1, :string
    add_column :users, :address2, :string
    add_column :users, :area, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :image_id, :string
  end
end
