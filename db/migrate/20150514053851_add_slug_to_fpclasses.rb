class AddSlugToFpclasses < ActiveRecord::Migration
  def change
    add_column :fpclasses, :slug, :string
    add_index :fpclasses, :slug, unique: true
  end
end
