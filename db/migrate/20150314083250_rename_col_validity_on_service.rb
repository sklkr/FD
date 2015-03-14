class RenameColValidityOnService < ActiveRecord::Migration
  def change
  	remove_column :services, :validity
  	add_column :services, :validity, :integer 
  end
end
