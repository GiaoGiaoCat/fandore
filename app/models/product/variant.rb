class Product::Variant < ActiveRecord::Base

  attr_accessor :remark
  # table name
  self.table_name = 'variants'
  # extends ...................................................................
  acts_as_paranoid
  # includes ..................................................................
  include DefaultPrice
  # constants .................................................................
  # related macros ............................................................
  belongs_to :product, touch: true, inverse_of: :variants
  # belongs_to :tax_category
  has_many :line_items, class_name: "Order::LineItem", dependent: :destroy
  has_many :orders, through: :line_items

  has_many :option_value_variants
  has_many :option_values, through: :option_value_variants
  has_many :prices, class_name: 'Product::Price', dependent: :destroy
  # relationships .............................................................
  # validations ...............................................................
  validates_uniqueness_of :sku, conditions: -> { where(deleted_at: nil) }, allow_blank: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  # callbacks .................................................................
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  enum status: [ :available, :sold, :unavailable ]


  # class methods .............................................................
  # public instance methods ...................................................
  def options_text
    values = self.option_values.sort do |a, b|
      a.option_type.position <=> b.option_type.position
    end

    values.to_a.map! do |ov|
      "#{ov.option_type.presentation}: #{ov.presentation}"
    end

    values.to_sentence({ words_connector: ", ", two_words_connector: ", " })
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
end
