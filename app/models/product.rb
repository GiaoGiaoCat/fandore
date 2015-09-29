class Product < ActiveRecord::Base
  # extends ...................................................................
  acts_as_paranoid
  acts_as_favable
  # includes ..................................................................
  # constants .................................................................
  # related macros ............................................................
  attr_accessor :prototype_id, :option_values_hash
  # relationships .............................................................
  has_many :product_option_types, dependent: :destroy, inverse_of: :product
  has_many :option_types, through: :product_option_types
  has_many :product_properties, dependent: :destroy, inverse_of: :product
  has_many :properties, through: :product_properties

  has_many :classifications, class_name: 'Taxonomy::Classification', dependent: :delete_all, inverse_of: :product
  has_many :taxons, class_name: 'Taxonomy::Taxon', through: :classifications

  has_one :master, -> { where(is_master: true) }, class_name: 'Product::Variant', autosave: true, inverse_of: :product
  has_many :variants, -> { where(is_master: false) }, inverse_of: :product
  has_many :variants_including_master, class_name: 'Product::Variant', dependent: :destroy, inverse_of: :product
  has_many :line_items, through: :variants_including_master
  has_many :orders, through: :line_items

  has_many :recommendations
  has_many :recommend_products, through: :recommendations
  has_many :inverse_recommendations, class_name: 'Product::Recommendation', foreign_key: 'recommend_product_id'
  has_many :inverse_recommend_products, through: :inverse_recommendations, source: :product
  has_many :variant_images, -> { order(:position) }, source: :images, through: :variants_including_master
  # validations ...............................................................
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :meta_keywords, length: { maximum: 255 }
  validates :meta_title, length: { maximum: 255 }
  # validates :shipping_category_id, presence: true

  # callbacks .................................................................
  after_create :add_associations_from_prototype
  after_create :build_variants_from_option_values_hash, if: :option_values_hash

  after_initialize :ensure_master

  after_save :save_master

  before_destroy :ensure_not_referenced_by_any_line_item
  # scopes ....................................................................
  scope :goods, -> { joins(:taxons).merge(Taxonomy::Taxon.goods) }
  scope :diamonds, -> { joins(:taxons).merge(Taxonomy::Taxon.diamond) }
  # other macros (like devise's) ..............................................
  accepts_nested_attributes_for :product_properties, allow_destroy: true

  # delegate :sku, :price, :currency, :display_amount, :display_price, :weight, :height, :width, :depth, :is_master, :has_default_price?, :cost_currency, :price_in, :amount_in, to: :master
  delegate :sku, :sku=, :price, :price=, :status, :status=, to: :master
  # class methods .............................................................
  # public instance methods ...................................................

  def product_image
    variants_including_master.first || Image.default_image
  end

  def max_variants_images_position
    variant_images.unscope(:order).order(position: :desc).first.try(:position) || 0
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
  private

  def add_associations_from_prototype
    if prototype_id && prototype = Product::Prototype.find_by(id: prototype_id)
      prototype.properties.each { |property| product_properties.create(property: property) }
      self.option_types = prototype.option_types
    end
  end

  def save_master
    master.save! if master && (master.new_record? || master.changed?)
  end

  def ensure_master
    return unless new_record?
    self.master ||= build_master
  end

  # Ensures option_types and product_option_types exist for keys in option_values_hash
  def ensure_option_types_exist_for_values_hash
    return if option_values_hash.nil?
    option_values_hash.keys.map(&:to_i).each do |id|
      self.option_type_ids << id unless option_type_ids.include?(id)
      product_option_types.create(option_type_id: id) unless product_option_types.pluck(:option_type_id).include?(id)
    end
  end

  # Builds variants from a hash of option types & values
  def build_variants_from_option_values_hash
    ensure_option_types_exist_for_values_hash
    values = option_values_hash.values
    values = values.inject(values.shift) { |memo, value| memo.product(value).map(&:flatten) }

    values.each do |ids|
      variant = variants.create(
        option_value_ids: ids,
        price: master.price
      )
    end
    save
  end

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Item present.')
      return false
    end
  end
end
