class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  validates :username, length: {minimum:4, maximum:16}
end
