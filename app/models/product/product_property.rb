class Product::ProductProperty < ActiveRecord::Base
  # table name
  self.table_name = 'product_properties'
  # extends ...................................................................
  acts_as_list scope: :product
  # includes ..................................................................
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  belongs_to :product, touch: true, inverse_of: :product_properties
  belongs_to :property, inverse_of: :product_properties
  # validations ...............................................................
  validates :property, presence: true
  validates :value, length: { maximum: 191 }
  # callbacks .................................................................
  # scopes ....................................................................
  # other macros (like devise's) ..............................................
  delegate :presentation, to: :property
  # class methods .............................................................
  # public instance methods ...................................................
  # virtual attributes for use with AJAX completion stuff
  def property_name
    property.name if property
  end

  def property_name=(name)
    unless name.blank?
      unless property = Product::Property.find_by(name: name)
        property = Product::Property.create(name: name, presentation: name)
      end
      self.property = property
    end
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
end
