class CreateServicesInstructorsJoinTable < ActiveRecord::Migration
  def change
    create_table :services_instructors, id: false do |t|
      t.belongs_to :service, index: true
      t.belongs_to :instructor, index: true
    end
  end
end
