class User::PasswordChangeForm < ActiveType::Object
  attribute :username, :string
  attribute :password, :string
  attribute :new_password, :string
  attribute :password_confirmation, :string

  validates :new_password, confirmation: true, presence: true, length: { in: 6..20 }
  validate :validate_user_exists
  validate :validate_password_correct

  after_save :change_password

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

  def change_password
    user.update_attribute(:password, new_password)
  end
end
