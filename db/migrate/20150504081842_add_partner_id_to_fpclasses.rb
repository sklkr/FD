class AddPartnerIdToFpclasses < ActiveRecord::Migration
  def change
    add_column :fpclasses, :partner_id, :integer
  end
end
