class User < ApplicationRecord
  has_many :posts
  has_many :votes

  validates :name, presence: true, uniqueness: true
  validates :password, :length => {:in => 4..15}
  validates :name, :length => {:maximum => 12}

  has_secure_password
end
