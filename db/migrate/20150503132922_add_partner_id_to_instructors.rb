class AddPartnerIdToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :partner_id, :integer
  end
end
