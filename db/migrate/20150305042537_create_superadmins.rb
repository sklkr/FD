class CreateSuperadmins < ActiveRecord::Migration
  def change
    create_table :superadmins do |t|
      t.string :email

      t.timestamps
    end
  end
end
