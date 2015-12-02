class User < ActiveRecord::Base
  # extends ...................................................................
  has_secure_password
  has_one_time_password length: 6
  # includes ..................................................................
  include Trackable
  include Lockable
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  has_one :profile, dependent: :destroy
  has_one :cart, class_name: 'Order::Cart'
  has_many :verification_codes, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :line_items, through: :orders, class_name: 'Order::LineItem', dependent: :destroy
  has_many :comments, dependent: :destroy
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
            allow_blank: true,
            format: { with: Fandore::Regex::EMAIL_REGEX }
  # callbacks .................................................................
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  BACKEND_ROLES = [:admin, :customer_service, :product_manager]
  FRONTEND_ROLES = [:member]
  ROLES = [:admin, :member, :customer_service, :product_manager]

  enum role: ROLES

  accepts_nested_attributes_for :profile, update_only: true

  delegate :name, :gender, :avatar, :birthday, to: :profile
  # class methods .............................................................
  # public instance methods ...................................................
  def profile
    super || build_profile
  end

  # defines: `backend_user?`, `frontend_user?`
  def self.user_role_devise_method_define(*kindles)
    kindles.each do |item|
      define_method "#{item}_user?" do
        self.class.const_get("#{item.upcase}_ROLES").include? role.to_sym
      end
    end
  end
  user_role_devise_method_define('backend', 'frontend')
  # protected instance methods ................................................
  # private instance methods ..................................................
end
