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
    if user && !user.activated_at
      user.update_attribute(:activated_at, Time.now)
    end
  end

end
