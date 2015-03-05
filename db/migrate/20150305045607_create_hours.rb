class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.integer :sun_from
      t.integer :mon_from
      t.integer :tue_from
      t.integer :wed_from
      t.integer :thu_from
      t.integer :fri_from
      t.integer :sat_from
      t.integer :sun_to
      t.integer :mon_to
      t.integer :tue_to
      t.integer :wed_to
      t.integer :thu_to
      t.integer :fri_to
      t.integer :sat_to

      t.timestamps
    end
  end
end
