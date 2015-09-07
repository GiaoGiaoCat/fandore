class Product::Price < ActiveRecord::Base

  self.table_name = "prices"

  # relationships .............................................................
  belongs_to :variant, class_name: "Product::Variant"
  # validations ...............................................................
  validates :price, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

end
