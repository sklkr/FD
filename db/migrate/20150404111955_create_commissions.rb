class CreateCommissions < ActiveRecord::Migration
  def change
    create_table :commissions do |t|
      t.float :val
      t.integer :center_id
      t.integer :partner_id
      t.integer :service_id

      t.timestamps
    end
  end
end
