class User < ActiveRecord::Base

  has_secure_password

  validates :name, presence: true
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  before_save :downcase_fields

   def downcase_fields
      self.email.downcase!
   end

  def self.authenticate_with_credentials(email, password)
    modified_email = email.strip.downcase
    user = User.find_by_email(modified_email)

    if user && user.authenticate(password)
      return user  
    else
      return nil
    end
  end

end
