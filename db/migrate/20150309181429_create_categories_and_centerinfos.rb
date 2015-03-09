class CreateCategoriesAndCenterinfos < ActiveRecord::Migration
  def change
    create_table :categories_centerinfos, id: false do |t|
    	t.belongs_to :centerinfo, index: true
    	t.belongs_to :category, index: true
    end
  end
end
