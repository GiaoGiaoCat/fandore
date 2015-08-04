class Product::Variant < ActiveRecord::Base
  # table name
  self.table_name = 'variants'
  # extends ...................................................................
  extend Enumerize
  acts_as_paranoid
  # includes ..................................................................
  # constants .................................................................
  # related macros ............................................................
  belongs_to :product, touch: true, inverse_of: :variants
  # belongs_to :tax_category

  has_many :option_value_variants
  has_many :option_values, through: :option_value_variants
  # relationships .............................................................
  # validations ...............................................................
  validates_uniqueness_of :sku, conditions: -> { where(deleted_at: nil) }, allow_blank: true
  # callbacks .................................................................
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  enumerize :status, in: { available: 0, sold: 1, unavailable: 2 }, default: :available # 在售 已售 不可用

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
