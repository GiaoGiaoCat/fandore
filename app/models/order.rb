class Order < ActiveRecord::Base
  # table name
  # extends ...................................................................
  # includes ..................................................................
  include OrderStates
  include NumberGenerator
  include TrackInfo
  include EncryptedId
  # constants .................................................................
  # related macros ............................................................
  attr_accessor :use_shipping
  # relationships .............................................................
  # belongs_to :store
  belongs_to :user
  belongs_to :invoice, class_name: "Order::Invoice", foreign_key: "invoice_id"
  belongs_to :created_by, class_name: 'User'
  belongs_to :approver, class_name: 'User'
  belongs_to :canceler, class_name: 'User'

  belongs_to :billing_address, class_name: 'User::Address'
  belongs_to :shipping_address, class_name: 'User::Address'

  has_many :line_items, dependent: :destroy, inverse_of: :order
  has_many :variants, through: :line_items
  has_many :products, through: :variants
  has_many :diamonds, -> { where.not(ancestry: nil) }, class_name: 'LineItem'
  has_many :payments, dependent: :destroy
  # has_many :refunds, through: :payments
  # has_many :return_authorizations, dependent: :destroy, inverse_of: :order
  # has_many :reimbursements, inverse_of: :order
  # has_many :adjustments, -> { order("#{Adjustment.table_name}.created_at ASC") }, as: :adjustable, dependent: :destroy
  # has_many :line_item_adjustments, through: :line_items, source: :adjustments
  # has_many :shipment_adjustments, through: :shipments, source: :adjustments
  # has_many :inventory_units, inverse_of: :order

  # has_and_belongs_to_many :promotions, join_table: 'orders_promotions'
  # has_many :shipments, dependent: :destroy, inverse_of: :order

  # validations ...............................................................
  # callbacks .................................................................
  before_validation :clone_shipping_address, if: :use_shipping?
  before_create :create_token, :link_by_email
  after_create :initial_totals
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  encrypted_id key: '9L4cFdvMFuJvrVncseZNKV'
  accepts_nested_attributes_for :line_items
  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :shipping_address
  # accepts_nested_attributes_for :payments
  # accepts_nested_attributes_for :shipments
  delegate :url_helpers, to: 'Rails.application.routes'
  delegate :name, to: :shipping_address
  alias_method :customer_name, :name
  # class methods .............................................................
  # public instance methods ...................................................

  def shipping_address
    super || build_shipping_address(user_id: user_id)
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  # NOTE: 暂时没用上
  def amount
    line_items.inject(0.0) { |sum, li| sum + li.amount }
  end

  def pay_url
    Alipay::Service.create_direct_pay_by_user_url(
      out_trade_no: number,
      subject: 'Order Name',
      total_fee: 0.01,
      return_url: url_helpers.alipay_done_order_url(self, host: Figaro.env.site_domain),
      notify_url: url_helpers.alipay_notify_orders_url(host: Figaro.env.site_domain)
    )
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
  private

  def link_by_email
    self.email = user.email if self.user
  end

  def clone_shipping_address
    if shipping_address && billing_address.nil?
      self.billing_address = shipping_address.clone
    else
      self.billing_address.attributes = shipping_address.attributes.except('id', 'updated_at', 'created_at')
    end
    true
  end

  def create_token
    self.guest_token ||= loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(guest_token: random_token)
    end
  end

  def use_shipping?
    # @use_shipping == true || @use_shipping == 'true' || @use_shipping == '1'
    @use_shipping == true
  end
end
