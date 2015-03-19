class AddUserIdToSuperadmins < ActiveRecord::Migration
  def change
    add_column :superadmins, :user_id, :integer
  end
end
