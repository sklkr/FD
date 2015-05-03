class CreateExperiencesAndCenters < ActiveRecord::Migration
  def change
    create_table :centers_experiences, id: false do |t|
    	t.belongs_to :center, index: true
    	t.belongs_to :experience, index: true
    end
  end
end
