class CreateClasbkings < ActiveRecord::Migration
  def change
    create_table :clasbkings do |t|
      t.references :customer, index: true
      t.references :fpclass, index: true
      t.references :passport, index: true
      t.string :status

      t.timestamps
    end
  end
end
