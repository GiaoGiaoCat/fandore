module DefaultPrice
  extend ActiveSupport::Concern

  included do
    has_one :default_price, class_name: 'Product::Price', dependent: :destroy

    delegate :price, :price=, to: :default_price

    accepts_nested_attributes_for :default_price
  end

  module ClassMethods
  end

  def default_price
    super || build_default_price
  end
end
