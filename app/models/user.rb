require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  
  # Associations
  has_one :partner
  has_one :customer
  has_one :superadmin
  belongs_to :centertype
  belongs_to :city
  belongs_to :area
  has_one :centerman

  ratyrate_rater
  before_create :generate_confirmation_token
  accepts_nested_attributes_for :customer
  attachment :image

  def full_name
    "#{self.try(:first_name)}  #{self.try(:last_name)}".blank? ? "Anonymous" : "#{self.try(:first_name)}  #{self.try(:last_name)}"
  end

  def full_name=(full_name)
    self.first_name, self.last_name = full_name.split(' ')
  end

  def password
    @password ||= Password.new(self.crypted_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.crypted_password = @password
  end

  def confirm!
    self.confirmation_token = nil
    self.confirmed_at = Time.now.utc
    self.save!
  end

  def name
    self.first_name.capitalize + " " + self.last_name.capitalize
  end

  # Password Reset 
  def send_password_reset(role)
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(role).delay.deliver
  end

  # used for password resets 
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end



private

  def generate_confirmation_token
    loop do
      token = SecureRandom.urlsafe_base64
      unless User.where(:remember_token => token).any?
        self.remember_token = token
        self.remember_token_expires_at = Time.now.utc
        break
      end
    end
  end
end