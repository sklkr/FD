class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :order, index: true, :null => false
      t.decimal :amount, :null => false, :precision => 8, :scale => 2
      t.string :invoice_type, :null => false, :default => Invoice::PURCHASE
      t.string :state, :null => false
      t.boolean :active, :null => false, :default => true

      t.timestamps
    end
  end
end
