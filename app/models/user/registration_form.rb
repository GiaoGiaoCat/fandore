class User::RegistrationForm < ActiveType::Record[User]
  # attribute :verification_code, :string

  validates :password, confirmation: true, presence: true, length: { in: 6..20 }

  # validates :invitation_code, numericality: true, allow_blank: true
  # validates :verification_code, presence: true
  # validate :validate_verify_code_correct

  # def set_invitation_code!(invitation_code)
  #   return unless invitation_code
  #   update_column(:invitation_code, invitation_code)
  # end

  # private
  # def validate_verify_code_correct
  #   v_code = CellphoneVerificationCode.find_by(phone_number: cellphone_number)
  #   errors.add(:base, :verify_code_error) unless v_code.verify?(verification_code)
  # end

end
