class User < ActiveRecord::Base
  # extends ...................................................................
  has_secure_password
  has_one_time_password length: 6
  enum role: [:admin, :ordinary]
  # includes ..................................................................
  include Trackable
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  has_one :profile, dependent: :destroy
  has_many :verification_codes, dependent: :destroy
  has_many :addresses, dependent: :destroy
  # validations ...............................................................
  validates :password,
            confirmation: true,
            presence: true,
            length: { in: 6..20 },
            allow_blank: true
  validates :mobile,
            presence: true,
            uniqueness: true,
            format: { with: /\A(13[0-9]|15[0-9]|18[7-8])[0-9]{8}\z/ }
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  # callbacks .................................................................
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  accepts_nested_attributes_for :profile, update_only: true
  delegate :name, :gender, to: :profile
  # class methods .............................................................
  # public instance methods ...................................................
  def profile
    super || build_profile
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
end
