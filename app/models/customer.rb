class Customer < ActiveRecord::Base
  extend FriendlyId
  
  belongs_to :user, dependent: :destroy
  friendly_id :email
  has_many :bookings, dependent: :destroy
  has_one :identity, dependent: :destroy


  accepts_nested_attributes_for :user, :identity
  # Validations
  validates :email, :presence => true, :uniqueness => true
  validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, :message => "Email not valid"

  def customer_id
  	"FP" + sprintf('%04d', self.id)
  end

  # For Facebook authentication
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

end
