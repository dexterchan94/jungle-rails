class User < ActiveRecord::Base

  has_secure_password

  validates :name, presence: true
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

end
