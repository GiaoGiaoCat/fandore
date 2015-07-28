class User::LoginForm < ActiveType::Object
  attribute :username, :string
  attribute :password, :string
  attribute :remember_me, :boolean
  attribute :remote_ip, :string

  validate :validate_user_exists
  validate :validate_password_correct

  after_save :log_user_sign_in_ip

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

  def log_user_sign_in_ip
    user.update_columns(last_sign_in_at: Time.now, last_sign_in_ip: remote_ip)
  end

end
