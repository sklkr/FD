class CreateAccountinfos < ActiveRecord::Migration
  def change
    create_table :accountinfos do |t|
      t.integer :brand_id
      t.string :centername
      t.string :personname
      t.string :email
      t.string :mobile
      t.string :landline
      t.string :area
      t.text :address_1
      t.text :address_2
      t.string :landmark
      t.string :city
      t.integer :pin
      t.string :pan
      t.string :tan
      t.string :tin
      t.string :taxregno
      t.string :acno
      t.string :bank_name
      t.string :ifsc_code
      t.text :bank_address

      t.timestamps
    end
  end
end
