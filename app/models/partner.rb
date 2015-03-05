class Partner < ActiveRecord::Base
  has_one :user, foreign_key: 'member_id'
  validates :email, :presence => true
end
