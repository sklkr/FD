class AddExpiredAtToClasbkings < ActiveRecord::Migration
  def change
    add_column :clasbkings, :expired_at, :date
  end
end
