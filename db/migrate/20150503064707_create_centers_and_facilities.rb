class CreateCentersAndFacilities < ActiveRecord::Migration
  def change
    create_table :centers_facilities, id: false do |t|
    	t.belongs_to :center, index: true
    	t.belongs_to :facility, index: true
    end
  end
end
