class CreateExperiencesAndCenterinfos < ActiveRecord::Migration
  def change
    create_table :centerinfos_experiences, id: false do |t|
    	t.belongs_to :centerinfo, index: true
    	t.belongs_to :experience, index: true
    end
  end
end
