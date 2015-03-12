class AddMissingIndexes < ActiveRecord::Migration
  def change
	add_index :accountinfos, :center_id
    add_index :accountinfos, :brand_id
    add_index :average_caches, :rater_id
    add_index :average_caches, [:rateable_id, :rateable_type]
    add_index :centers, :partner_id
    add_index :centerinfos, :centertype_id
    add_index :centerinfos, :center_id
    add_index :centerinfos, :hour_id
    add_index :instructors, :center_id
    add_index :overall_averages, [:rateable_id, :rateable_type]
    add_index :services, :center_id
    add_index :services, :category_id
    add_index :users, :member_id
  		
  end
end
