class AddFbActiveToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :fb_active, :boolean, default: false
  end
end
