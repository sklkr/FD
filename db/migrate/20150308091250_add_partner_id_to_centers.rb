class AddPartnerIdToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :partner_id, :integer
  end
end
