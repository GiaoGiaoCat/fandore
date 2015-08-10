class Order < ActiveRecord::Base
  # table name
  # extends ...................................................................
  # includes ..................................................................
  include AASM
  aasm :column => 'state' do
    state :pending, :initial => true
    state :paid
    state :md_ready
    state :inlaided
    state :packed
    state :delivery
    state :complete
    state :canceled
    state :closed
    state :resume

    event :paid do
      transitions :from => :pending, :to => :paid
    end

    event :md_ready do
      transitions :from => :paid, :to => :md_ready
    end

    event :inlaided do
      transitions :from => :md_ready, :to => :inlaided
    end   

    event :packed do
      transitions :from => :inlaided, :to => :packed
    end

    event :delivery do
      transitions :from => :packed, :to => :delivery
    end

    event :complete do
      transitions :from => :delivery, :to => :complete
    end

    event :canceled do
      transitions :from => :pending, :to => :canceled
    end

    event :closed do
      transitions :from => :complete, :to => :closed
    end

    event :resume do
      transitions :from => :closed, :to => :resume
    end

  end
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  belongs_to :user
  belongs_to :created_by, class_name: 'User'
  belongs_to :approver, class_name: 'User'
  belongs_to :canceler, class_name: 'User'

  belongs_to :billing_address, class_name: 'User::Address'
  belongs_to :shipping_address, class_name: 'User::Address'

  has_many :line_items, dependent: :destroy, inverse_of: :order
  has_many :variants, through: :line_items
  has_many :products, through: :variants
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  accepts_nested_attributes_for :line_items
  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :shipping_address
  # accepts_nested_attributes_for :payments
  # accepts_nested_attributes_for :shipments
  # class methods .............................................................
  def self.set_order(line_items, user, address)
    item_count = line_items.sum(:quantity)
    item_total = 0
    line_items.each do |line_item|
      item_total += line_item.price * line_item.quantity
    end
    # 缺少优惠价格，调整价格
    @order = Order.create(item_total: item_total, item_count: item_count, user: user, email: user.email, shipping_address: address)
    Order::LineItem.to_order(line_items, @order)
  end
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end
