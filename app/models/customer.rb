class Customer < ActiveRecord::Base
  extend FriendlyId
  acts_as_commontator
  delegate :first_name, :last_name, :phone, :password, :password=, :crypted_password, :image_id, :active, :full_name, :password_reset_token, :send_password_reset, to: :user
  
  belongs_to :user, dependent: :destroy
  friendly_id :email
  has_many :bookings, dependent: :destroy
  has_one :identity, dependent: :destroy
  has_many :orders
  has_one :passport
  has_many :clasbkings

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

  # def subscribe_to_mailchimp testing=false
  #   return true if (Rails.env.test? && !testing)
  #   list_id = ENV['MAILCHIMP_ULUDUM_LIST_ID']

  #   response = Rails.configuration.mailchimp.lists.subscribe({
  #     id: list_id,
  #     email: {email: email},
  #     double_optin: false,
  #   })
  #   response
  # end
end
