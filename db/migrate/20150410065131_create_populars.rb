class CreatePopulars < ActiveRecord::Migration
  def change
    create_table :populars do |t|
      t.references :center, index: true
      t.references :partner, index: true
      t.integer :rank
      t.references :category, index: true
      
      t.timestamps
    end
  end
end
