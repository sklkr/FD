class CreateTrainers < ActiveRecord::Migration
  def change
    create_table :trainers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :location
      t.string :service
      t.datetime :date
      t.text :comment
      t.text :address
      t.string :status

      t.timestamps
    end
  end
end
