class User::LoginForm < ActiveType::Object
  include SimpleCaptchaReloaded::Model
  attribute :username, :string
  attribute :password, :string
  attribute :remember_me, :boolean

  validate :validate_user_exists
  validate :validate_password_correct

  def user
    User.ransack(email_or_mobile_eq: username).result.first
  end

  private

  def validate_user_exists
    errors.add(:base, :user_not_found) unless user
  end

  def validate_password_correct
    if user && !user.authenticate(password)
      errors.add(:password, :incorrect)
    end
  end

end
