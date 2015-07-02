class AddTimingsToFpclasses < ActiveRecord::Migration
  def change
    add_column :fpclasses, :timings, :text, array: true, default: []
    
    add_index  :fpclasses, :timings, using: 'gin'
  end
end
