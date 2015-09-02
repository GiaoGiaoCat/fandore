class User::LoginForm < ActiveType::Object
  include SimpleCaptchaReloaded::Model
  attribute :username, :string
  attribute :password, :string
  attribute :remember_me, :boolean
  attribute :captcha, :string
  attribute :captcha_key, :string

  validate :validate_user_exists
  validate :validate_password_correct
  validate :validate_user_lock_state

  def user
    User.ransack(email_or_mobile_eq: username).result.first
  end

  private

  def validate_user_lock_state
    if(user && user.last_pwd_failed_at.try(:today?) && (user.pwd_failed_count > 5))
      errors.add(:base, :locked)
    end
  end

  def validate_user_exists
    errors.add(:base, :user_not_found) unless user
  end

  def validate_password_correct
    if user && !user.authenticate(password)
      errors.add(:password, :incorrect)
    end
  end

end
