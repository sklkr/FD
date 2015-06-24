class AddReferralCodeToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :referral_code, :string
    add_column :customers, :referral_id, :integer
  end
end
