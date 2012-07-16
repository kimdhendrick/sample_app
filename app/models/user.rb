# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_many :microposts, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
    uniqueness: { case_sensitive: false }, 
    format: { with: VALID_EMAIL_REGEX }

  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }
  has_secure_password
  
  #before_save { |user| user.email = email.downcase }
  before_save { self.email.downcase! }
  before_save :create_remember_token

  def feed
      # This is preliminary. See "Following users" for the full implementation.
      Micropost.where("user_id = ?", id)
  end      
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
  
end
