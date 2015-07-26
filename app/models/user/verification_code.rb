class User::VerificationCode < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  # constants .................................................................
  self.table_name = "verification_codes"
  # related macros ............................................................
  # relationships .............................................................
  belongs_to :user
  # validations ...............................................................
  validates :mobile,
            presence: true,
            format: { with: /\A(13[0-9]|15[0-9]|18[7-8])[0-9]{8}\z/ }
  validate :validate_time_interval
  # callbacks .................................................................
  before_create :generate_code
  # after_create :send_sms
  # scopes ....................................................................
  default_scope { order("id DESC") }
  # other macros (like devise's) ..............................................
  # class methods .............................................................
  # public instance methods ...................................................
  def verify?(code)
    self.code == code
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
  private

  def generate_code
    self.code = SecureRandom.random_number.to_s[2, 6]
  end

  def send_sms
    pusher = Submail.pusher('10330', '1f1bc2a6b1689a7ee02695a1967d7322')
    pusher.message_xsend(mobile, 'twMG94', { sms_reg_code: code })
  end

  def validate_time_interval
    v_code = User::VerificationCode.find_by_mobile(mobile)
    if v_code && (Time.now - v_code.created_at) <= 120
      errors.add(:base, :verify_code_time_interval_error)
    end
  end
end
