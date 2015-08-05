class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :brand
      t.string :bemail
      t.string :bmobile
      t.string :name
      t.text :address
      t.decimal :original_price, :precision => 8, :scale => 2
      t.decimal :selling_price, :precision => 8, :scale => 2
      t.text :timings, array: true, default: []
      t.text :about
      t.integer :quantity, default: 0
      t.string :city
      t.string :sublocation, array: true, default: []
      t.string :category, array: true, default: []
      t.string :subcategory, array: true, default: []
      t.boolean :active, default: false
      t.string :image_id

      t.timestamps
    end

    add_index  :deals, :timings, using: 'gin'
    add_index  :deals, :sublocation, using: 'gin'
    add_index  :deals, :category, using: 'gin'
    add_index  :deals, :subcategory, using: 'gin'
  end
end
