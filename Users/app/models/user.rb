class User < ActiveRecord::Base
   has_secure_password
  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret

  validates :password, length: { minimum: 8 }, allow_nil: true, on: [:update]

  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :name, :presence => true
  
  validates :email, :presence => true, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }
  
  # validates :password, :presence => true. only: [:create, :update]
end

