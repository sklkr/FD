class AddTypeToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :service_type, :integer, :default => 1
  end
end
