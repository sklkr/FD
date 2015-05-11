class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :customer, index: true
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end