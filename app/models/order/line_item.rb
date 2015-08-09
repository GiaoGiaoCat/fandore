class Order::LineItem < ActiveRecord::Base
  # table name
  self.table_name = 'line_items'
  # extends ...................................................................
  # includes ..................................................................
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  belongs_to :order, inverse_of: :line_items, touch: true
  belongs_to :variant,class_name: "Product::Variant", inverse_of: :line_items
  belongs_to :cart
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
  delegate :name, :description, :sku, to: :variant
  # class methods .............................................................
  # public instance methods ...................................................
  def amount
    price * quantity
  end

  def discounted_amount
    amount + promo_total
  end

  def final_amount
    amount + adjustment_total
  end
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
end
