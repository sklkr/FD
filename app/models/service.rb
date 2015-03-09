class Service < ActiveRecord::Base
 TYPE = [{'1' =>  'Regular Service'}, {'2' =>  'Upcoming Class'}]
 belongs_to :center
 belongs_to :category
end
