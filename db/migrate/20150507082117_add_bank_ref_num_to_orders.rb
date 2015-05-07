class AddBankRefNumToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :bank_ref_num, :string
    add_column :orders, :bankcode, :string
    add_column :orders, :name_on_card, :string
    add_column :orders, :cardnum, :string
    add_column :orders, :amount_split, :string
    add_column :orders, :payuMoneyId, :string
    add_column :orders, :discount, :string
    add_column :orders, :net_amount_debit, :string
  end
end
