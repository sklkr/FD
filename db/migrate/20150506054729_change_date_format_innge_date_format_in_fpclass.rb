class ChangeDateFormatInngeDateFormatInFpclass < ActiveRecord::Migration
  def change
    change_column :fpclasses, :date, :date
  end
end
