class AddBankCityToAccountinfo < ActiveRecord::Migration
  def change
    add_column :accountinfos, :bank_city, :string
  end
end
