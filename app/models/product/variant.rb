class Product::Variant < ActiveRecord::Base
  # table name
  self.table_name = 'variants'
  # extends ...................................................................
  acts_as_paranoid
  # includes ..................................................................
  # constants .................................................................
  # related macros ............................................................
  belongs_to :product, touch: true, inverse_of: :variants
  # belongs_to :tax_category
  has_many :line_items, class_name: "Order::LineItem", dependent: :destroy
  has_many :orders, through: :line_items

  has_many :option_value_variants
  has_many :option_values, through: :option_value_variants
  has_one :price_model, class_name: "Product::Price", dependent: :destroy, autosave: true, validate: true
  accepts_nested_attributes_for :price_model
  # relationships .............................................................
  # validations ...............................................................
  validates_uniqueness_of :sku, conditions: -> { where(deleted_at: nil) }, allow_blank: true
  # callbacks .................................................................
  after_initialize :ensure_price_model

  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  enum status: [ :available, :sold, :unavailable ]

  delegate :price, :price=, to: :price_model

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
  private

  def ensure_price_model
    return unless new_record?
    self.price_model ||= build_price_model
  end
end
