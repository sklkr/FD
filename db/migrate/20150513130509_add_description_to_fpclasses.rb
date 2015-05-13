class AddDescriptionToFpclasses < ActiveRecord::Migration
  def change
    add_column :fpclasses, :description, :text
    add_column :fpclasses, :level, :string
  end
end
