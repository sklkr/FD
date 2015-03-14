class Partner < ActiveRecord::Base
  belongs_to :user
  validates :email, :presence => true
  has_many :centers
end
