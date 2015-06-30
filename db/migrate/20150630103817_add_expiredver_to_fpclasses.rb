class AddExpiredverToFpclasses < ActiveRecord::Migration
  def change
    add_column :fpclasses, :expiredver, :datetime
  end
end
