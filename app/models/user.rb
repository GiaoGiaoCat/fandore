class User < ActiveRecord::Base
  # extends ...................................................................
  has_secure_password
  has_one_time_password length: 6
  # includes ..................................................................
  include Trackable
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  has_one :profile, dependent: :destroy
  has_many :verification_codes, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one :cart, class_name: "Order::Cart"
  # validations ...............................................................
  validates :password,
            confirmation: true,
            presence: true,
            length: { in: 6..20 },
            allow_blank: true
  validates :mobile,
            presence: true,
            uniqueness: true,
            format: { with: Fandore::Regex::PHONE_REGEX }
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: Fandore::Regex::EMAIL_REGEX }
  # callbacks .................................................................
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  enum role: [:admin, :member]
  accepts_nested_attributes_for :profile, update_only: true
  delegate :name, :gender, :avatar, :birthday, to: :profile
  # class methods .............................................................
  # public instance methods ...................................................
  def email_url
    if email.include?("gmail")
      "http://gmail.google.com/"
    else
      "http://mail.#{email.split('@')[1]}"
    end
  end

  def profile
    super || build_profile
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
end
