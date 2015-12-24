class Order::Cart < ActiveRecord::Base
  # table name
  self.table_name = 'carts'
  # extends ...................................................................
  # includes ..................................................................
  include EncryptedId
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  belongs_to :user
  has_many :line_items, dependent: :destroy, inverse_of: :cart
  has_many :variants, through: :line_items
  has_many :products, through: :variants
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  encrypted_id key: '5gA6lgr5g3GOg7EOQ1caYQ'
  accepts_nested_attributes_for :line_items
  # class methods .............................................................

  # public instance methods ...................................................
  def add_line_item(variant)
    current_item = line_items.find_or_initialize_by(variant_id: variant.id)
    current_item.quantity += 1 if current_item.persisted?
    current_item
  end

  def total_price
    # NOTE: amount 并不是最终价格，引入优惠码之后这里需要调整
    # line_items.to_a.sum { |item| item.amount }
    line_items.to_a.sum(&:amount)
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
end
