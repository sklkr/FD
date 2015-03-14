class AddUserIdToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :user_id, :integer
  end
end
