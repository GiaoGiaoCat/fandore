class User::RegistrationForm < ActiveType::Record[User]
  attribute :verification_code, :string

  validates :verification_code, presence: true, numericality: true
  validate :validate_verify_code_correct

  private

  def validate_verify_code_correct
    v_code = User::VerificationCode.find_by_to(mobile)
    errors.add(:base, :verify_code_error) unless v_code.verify?(verification_code)
  end

end
