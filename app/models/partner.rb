class Partner < ActiveRecord::Base
  has_one :user, foreign_key: 'member_id'
  validates :email, :presence => true
  has_many :centers
end
