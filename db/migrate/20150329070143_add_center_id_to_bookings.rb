class AddCenterIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :center_id, :integer
    add_column :bookings, :partner_id, :integer
  end
end
