class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  validate :username_complexity, :password_complexity

  scope :by_user, -> (username) { where('lower(username) = ?', username.downcase)}
  has_many :tasks, dependent: :destroy

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

  private
  def username_complexity
    return if username =~  /^[a-z0-9_-]{4,16}$/i
    errors.add :username, I18n.t('errors.username.invalid', { min: 4, max: 16 })
  end

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,16}$/
    errors.add :password, I18n.t('errors.password.invalid', { min: 8, max: 16 })
  end  
end
