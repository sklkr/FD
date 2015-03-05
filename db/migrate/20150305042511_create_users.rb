class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :first_name
      t.string :last_name
      t.string :crypted_password
      t.string :remember_token
      t.datetime :remember_token_expires_at
      t.integer :member_id

      t.timestamps
    end
  end
end
