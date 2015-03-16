class RemoveColumnExpiredOnServices < ActiveRecord::Migration
  def change
  	remove_column :services, :expired_on
  	add_column :services, :expired_on, :integer
  end
end
