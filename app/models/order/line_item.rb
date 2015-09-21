class Order::LineItem < ActiveRecord::Base
  # table name
  attr_accessor :remark
  self.table_name = 'line_items'
  # extends ...................................................................
  acts_as_commentable
  # includes ..................................................................
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  belongs_to :order, inverse_of: :line_items, touch: true
  belongs_to :cart, inverse_of: :line_items, touch: true
  belongs_to :variant, class_name: "Product::Variant", inverse_of: :line_items
  # belongs_to :tax_category
  has_one :product, through: :variant
  # has_many :adjustments, as: :adjustable, dependent: :destroy
  # has_many :inventory_units, inverse_of: :line_item
  # validations ...............................................................
  validates :variant, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :price, numericality: true
  # callbacks .................................................................
  before_validation :copy_price
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  delegate :name, :description, to: :product
  delegate :sku, to: :variant
  # class methods .............................................................
  # public instance methods ...................................................

  def amount
    price * quantity
  end

  def update_remark_to_order_and_cart
    order.remark[self.id] = @remark if order
    cart.remark[self.id] = @remark if cart
  end

  def remark=(remark)
    @remark = remark
    update_remark_to_order_and_cart
  end

  def remark
    i_remark = @remark || (order || cart).try(:remark) || {}
    i_remark[id] || ""
  end

  #callback ---------------------------------------
  after_destroy :remove_order_and_cart_remark
  # def discounted_amount
  #   amount + promo_total
  # end
  #
  # def final_amount
  #   amount + adjustment_total
  # end
  # protected instance methods ................................................
  # private instance methods ..................................................
  private

  def copy_price
    if variant
      self.price = variant.price if price.nil?
      # self.cost_price = variant.cost_price if cost_price.nil?
      # self.currency = variant.currency if currency.nil?
    end
  end

  def remove_order_and_cart_remark
    model = order || cart
    model.remark.delete(id)
    model.save()
  end
end
