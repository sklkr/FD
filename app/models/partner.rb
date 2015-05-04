class Partner < ActiveRecord::Base
  # An array of partner type
  PARTNERTYPES = ['center','professional']

  belongs_to :user, :dependent => :destroy
  has_many :centers, :dependent => :destroy
  has_many :bookings
  has_many :populars, :dependent => :destroy
  has_many :instructors
  has_many :fpclasses, :dependent => :destroy
  # Set partner type to center if we dont have partner type
  after_initialize do 
    if self.partner_type == '2'
      self.partner_type = "Partner::Trainer"
    else
      self.partner_type = "Partner::Center"
    end
   end

  accepts_nested_attributes_for :user, :centers
  # Validations
  validates :email, :presence => true, :uniqueness => true
  validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, :message => "Email not valid"
  
end
