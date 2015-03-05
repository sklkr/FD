class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.integer :photo_gid
      t.integer :center_id
      t.string :name
      t.string :gender
      t.string :mobile
      t.string :email
      t.string :expertise
      t.text :description

      t.timestamps
    end
  end
end
