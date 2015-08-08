class User::VerificationCode < ActiveRecord::Base
  # table name
  self.table_name = "verification_codes"
  # extends ...................................................................
  # includes ..................................................................
  # constants .................................................................
  # related macros ............................................................
  attr_accessor :method
  # relationships .............................................................
  belongs_to :user
  # validations ...............................................................
  validates :to, presence: true
  # validate :validate_time_interval
  # callbacks .................................................................
  before_create :generate_code
  after_create :send_notification
  # scopes ....................................................................
  default_scope { order("id DESC") }
  # other macros (like devise's) ..............................................
  # class methods .............................................................
  # public instance methods ...................................................
  after_initialize do
    # after_initialize is rails callback, not ruby builtin method
    # http://stackoverflow.com/a/23125577/1240067
    self.method ||= :send_verification
  end

  def verify?(code)
    self.code == code
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
  private

  def generate_code
    raise NotImplementedError, 'Must be implemented by subtypes.'
  end

  def send_notification
    raise NotImplementedError, 'Must be implemented by subtypes.'
  end

  def project_code
    raise NotImplementedError, 'Must be implemented by subtypes.'
  end

  def validate_time_interval
    v_code = User::VerificationCode.find_by_to(to)
    if v_code && (Time.now - v_code.created_at) <= 120
      errors.add(:base, :verify_code_time_interval_error)
    end
  end

end
