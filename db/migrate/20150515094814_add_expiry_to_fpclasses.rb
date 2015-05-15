class AddExpiryToFpclasses < ActiveRecord::Migration
  def change
    add_column :fpclasses, :expiry, :date
  end
end
