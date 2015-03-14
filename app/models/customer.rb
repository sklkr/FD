class Customer < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  validates :email, :presence => true
  friendly_id :email
end
