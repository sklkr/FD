class CreateCategoriesAndCenters < ActiveRecord::Migration
  def change
    create_table :categories_centers, id: false do |t|
    	t.belongs_to :center, index: true
    	t.belongs_to :category, index: true
    end
  end
end
