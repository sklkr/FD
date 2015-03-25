class CreateCentermen < ActiveRecord::Migration
  def change
    create_table :centermen do |t|
      t.string :email
      t.integer :user_id
      t.integer :center_id
      t.string :photo_id

      t.timestamps
    end
  end
end
