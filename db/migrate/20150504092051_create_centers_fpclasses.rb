class CreateCentersFpclasses < ActiveRecord::Migration
  def change
    create_table :centers_fpclasses do |t|
    	t.belongs_to :center, index: true
    	t.belongs_to :fpclass, index: true
    end
  end
end
