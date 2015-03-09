class RenameHoursColumnTypes < ActiveRecord::Migration
  def change
  	change_column :hours, :sun_from, :string
  	change_column :hours, :sun_to, :string
  	change_column :hours, :mon_from, :string
  	change_column :hours, :mon_to, :string
  	change_column :hours, :tue_from, :string
  	change_column :hours, :tue_to, :string
  	change_column :hours, :wed_from, :string
  	change_column :hours, :wed_to, :string
  	change_column :hours, :thu_from, :string
  	change_column :hours, :thu_to, :string
  	change_column :hours, :fri_from, :string
  	change_column :hours, :fri_to, :string
  	change_column :hours, :sat_from, :string
  	change_column :hours, :sat_to, :string
  end
end
