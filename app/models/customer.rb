class Customer < ActiveRecord::Base
  extend FriendlyId
  acts_as_commontator
  delegate :first_name, :emergency_name, :emergency_phone, :last_name, :phone, :password, :password=, :remember_token, :crypted_password, :location, :image_id, :active, :full_name, :password_reset_token, :send_password_reset, to: :user
  
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

  #referral 
  validates :referral_code, :uniqueness => true
  before_create :create_referral_code
  belongs_to :referrer, :class_name => "Customer", :foreign_key => "referral_id"
  has_many :referrals, :class_name => "Customer", :foreign_key => "referral_id"
  REFERRAL_STEPS = [
        {
            'count' => 5,
            "html" => "Shave<br>Cream",
            "class" => "two",
            "image" =>  ActionController::Base.helpers.asset_path("refer/cream-tooltip@2x.png")
        },
        {
            'count' => 10,
            "html" => "Truman Handle<br>w/ Blade",
            "class" => "three",
            "image" => ActionController::Base.helpers.asset_path("refer/truman@2x.png")
        },
        {
            'count' => 25,
            "html" => "Winston<br>Shave Set",
            "class" => "four",
            "image" => ActionController::Base.helpers.asset_path("refer/winston@2x.png")
        },
        {
            'count' => 50,
            "html" => "One Year<br>Free Blades",
            "class" => "five",
            "image" => ActionController::Base.helpers.asset_path("refer/blade-explain@2x.png")
        }
    ]


  scope :recent, -> { order(:created_at) }
  
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


  private
    def create_referral_code
       referral_code = SecureRandom.hex(5)
       @collision = Customer.find_by_referral_code(referral_code)

       while !@collision.nil?
           referral_code = SecureRandom.hex(5)
           @collision = Customer.find_by_referral_code(referral_code)
       end

       self.referral_code = referral_code
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
