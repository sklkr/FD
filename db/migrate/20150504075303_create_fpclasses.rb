class CreateFpclasses < ActiveRecord::Migration
  def change
    create_table :fpclasses do |t|
      t.string :name
      t.datetime :date
      t.string :start_time
      t.string :duration
      t.integer :seats
      t.references :instructor, index: true
      t.string :type_of

      t.timestamps
    end
  end
end
