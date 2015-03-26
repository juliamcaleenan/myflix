class User < ActiveRecord::Base
  has_many :reviews

  has_secure_password validations: false
  validates_presence_of :email_address, :password, :full_name
  validates_uniqueness_of :email_address
end