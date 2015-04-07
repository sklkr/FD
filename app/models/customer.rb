class Customer < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  friendly_id :email
  has_many :bookings
  
  # Validations
  validates :email, :presence => true, :uniqueness => true
  validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, :message => "Email not valid"

  def customer_id
  	"FP" + sprintf('%04d', self.id)
  end

end
