class RemoveDescriptionFromCoupon < ActiveRecord::Migration
  def change
    remove_column :coupons, :description
  end
end
