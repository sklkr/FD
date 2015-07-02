class AddRcdatesToFpclass < ActiveRecord::Migration
  def change
    add_column :fpclasses, :rcdates, :text, array: true, default: []
    
    add_index  :fpclasses, :rcdates, using: 'gin'
  end
end
