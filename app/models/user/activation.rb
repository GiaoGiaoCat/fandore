class User::Activation < ActiveType::Object
  attribute :code, :string
  attribute :to, :string

  after_save :activate_user

  def verification_code
    User::VerificationCode.find_by_code(code)
  end

  def to
    verification_code.to
  end

  def user
    User.ransack(email_or_mobile_eq: to).result.first
  end

  private

  def activate_user
    if user && !user.is_email_actived?
      user.update_attribute(:is_email_actived, true)
    end
  end

end
