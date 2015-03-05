require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  belongs_to :customer
  
  before_create :generate_confirmation_token

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