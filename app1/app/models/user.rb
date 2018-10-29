class User < ApplicationRecord
  acts_as_token_authenticatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments
  def name; email.split("@").first; end
  def owns?(comment)
    self == comment.user 
  end
end
