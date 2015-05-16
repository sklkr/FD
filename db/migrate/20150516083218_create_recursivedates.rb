class CreateRecursivedates < ActiveRecord::Migration
  def change
    create_table :recursivedates do |t|
      t.date :ondate
      t.references :fpclass, index: true

      t.timestamps
    end
  end
end
