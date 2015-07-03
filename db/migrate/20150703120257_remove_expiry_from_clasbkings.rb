class RemoveExpiryFromClasbkings < ActiveRecord::Migration
  def change
    remove_column :clasbkings, :expired_at, :date
    add_column :clasbkings, :expired_at, :datetime
  end
end
