class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :ac_no
      t.string :bank_name
      t.string :ifsc
      t.string :bank_address
      t.string :bank_location
      t.string :pan
      t.string :service_tax
      t.string :panproof
      t.string :idproof
      t.string :taxproof
      t.references :partner, index: true

      t.timestamps
    end
  end
end
