class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.references :customer, index: true
      t.string :status

      t.timestamps
    end
  end
end
