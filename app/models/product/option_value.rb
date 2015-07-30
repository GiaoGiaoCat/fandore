class Product::OptionValue < ActiveRecord::Base
  # table name
  self.table_name = 'option_values'
  # extends ...................................................................
  acts_as_list scope: :option_type
  # includes ..................................................................
  # constants .................................................................
  # related macros ............................................................
  # relationships .............................................................
  belongs_to :option_type, touch: true, inverse_of: :option_values
  # has_and_belongs_to_many :variants
  # validations ...............................................................
  validates :name, :presentation, presence: true
  # callbacks .................................................................
  # after_touch :touch_all_variants
  # scopes ....................................................................
  default_scope -> { order(:position) }
  # other macros (like devise's) ..............................................
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
  private
  def touch_all_variants
    # This can cause a cascade of products to be updated
    # To disable it in Rails 4.1, we can do this:
    # https://github.com/rails/rails/pull/12772
    # Product.no_touching do
      variants.find_each(&:touch)
    # end
  end
end
