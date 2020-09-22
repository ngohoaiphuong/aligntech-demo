class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  validates :username, length: {minimum:4, maximum:16}

  class << self
    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if (username = conditions.delete(:username))
        where(conditions.to_h).
        where([
          'lower(username) = :value',
          { value: username.strip.downcase }
        ]).first
      elsif conditions.has_key?(:username)
        where(conditions.to_h).first
      end
    end
  end  
end
