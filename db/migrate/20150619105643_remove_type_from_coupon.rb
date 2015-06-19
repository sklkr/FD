class RemoveTypeFromCoupon < ActiveRecord::Migration
  def change
    remove_column :coupons, :type
  end
end
