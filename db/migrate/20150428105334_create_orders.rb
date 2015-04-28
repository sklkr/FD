class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :token
      t.string :email_address
      t.string :phone_number
      t.string :status
      t.string :ip_address
      t.decimal :amount_paid, :precision => 8, :scale => 2
      t.string :invoice_number
      t.integer :service_id
      t.integer :center_id

      t.timestamps
    end
  end
end
