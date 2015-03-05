class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :email

      t.timestamps
    end
  end
end
