class Superadmin < ActiveRecord::Base
	validates :email, :presence => true
end
