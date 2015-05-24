class AddCenterToClasbkings < ActiveRecord::Migration
  def change
    add_reference :clasbkings, :center, index: true
  end
end
