class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|
      t.string :pan_id
      t.string :tax_id
      t.string :address_id
      t.string :tan_id
      t.integer :center_id

      t.timestamps
    end
  end
end
