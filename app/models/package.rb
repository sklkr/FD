class Package < ActiveRecord::Base
  belongs_to :customer
  before_validation { self.token = SecureRandom.uuid  if self.token.blank? }
end
