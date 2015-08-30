class Order::Invoice < ActiveRecord::Base
  # table name
  self.table_name = 'invoices'
  # extends ...................................................................
  # includes ..................................................................
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  has_many :orders
  has_many :line_items, through: :orders, class_name: "Order::LineItem"
  # validations ...............................................................
  # validates :variant, presence: true
  # validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  # validates :price, numericality: true
  # callbacks .................................................................
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  # class methods .............................................................
  # public instance methods ...................................................

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

end
