class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:token_authenticatable,:name,:username
  # attr_accessible :title, :body
  has_many :machines
  #before_save :ensure_authentication_token
  has_many :log_books
end
