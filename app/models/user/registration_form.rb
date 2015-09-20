class User::RegistrationForm < ActiveType::Record[User]
  attribute :verification_code, :string
  attribute :role, :string, default: "member"

  validates :verification_code, presence: true, numericality: true
  validate :validate_verify_code_correct

  after_create :send_email_verification_code

  private

  def validate_verify_code_correct
    v_code = User::VerificationCode.find_by_to(mobile)
    errors.add(:base, :verify_code_error) unless v_code && v_code.verify?(verification_code)
  end

  def send_email_verification_code
    User::EmailVerificationCode.create(to: email)
  end

end
