class CreateCentertypes < ActiveRecord::Migration
  def change
    create_table :centertypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
