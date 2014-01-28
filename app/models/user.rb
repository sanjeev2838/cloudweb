class User < ActiveRecord::Base
  attr_accessible :email, :name,:password, :password_confirmation,:admin,:ip_address,:last_login
  before_save { self.email = email.downcase }
  before_save :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
            format:     { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  #validates :password, length: { minimum: 6 }

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end



end
