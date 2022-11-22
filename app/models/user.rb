class User < ApplicationRecord
  
  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
  validates :password, length: { minimum: 8 }
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  has_secure_password
  
  
  def self.authenticate_with_credentials(email, password)
    stripped_email = email.strip.downcase
    user = self.where("LOWER(email) = ?", stripped_email).first
    return nil unless user && user.authenticate(password)
    user
  end

end