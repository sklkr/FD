class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.string :state
      t.string :classification
      t.string :population

      t.timestamps
    end
  end
end
