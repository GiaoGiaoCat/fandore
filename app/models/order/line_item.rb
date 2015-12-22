class Order::LineItem < ActiveRecord::Base
  # table name
  self.table_name = 'line_items'
  # extends ...................................................................
  acts_as_commentable
  has_ancestry
  # includes ..................................................................
  # constants .................................................................
  # related macros ............................................................
  attr_accessor :prototype_id
  # relationships .............................................................
  belongs_to :order, inverse_of: :line_items, touch: true
  belongs_to :cart, inverse_of: :line_items, touch: true
  belongs_to :variant, class_name: "Product::Variant", inverse_of: :line_items

  # belongs_to :item_resource, :polymorphic => true
  # belongs_to :tax_category
  has_one :product, through: :variant
  has_one :diamond
  # has_many :adjustments, as: :adjustable, dependent: :destroy
  # has_many :inventory_units, inverse_of: :line_item
  has_many :line_items_properties, class_name: "Order::LineItemProperty", dependent: :destroy, inverse_of: :line_item
  has_many :properties, through: :line_items_properties
  # validations ...............................................................
  validates :variant, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :price, numericality: true
  # callbacks .................................................................
  before_create :set_prototype
  after_create :add_associations_from_prototype
  before_validation :copy_price
  after_destroy :destroy_diamond
  # after_commit :update_related_parent_model_remark
  # scopes ....................................................................
  # TODO: 这里方法用来判断是否是戒指，需要重构
  scope :rings, -> { where(ancestry: nil) }
  # other macros (like devise's) ..............................................
  accepts_nested_attributes_for :line_items_properties, allow_destroy: true

  delegate :name, :description, to: :product
  delegate :is_diamond?, :is_wedding?, :is_engaement?, to: :product
  delegate :sku, to: :variant
  # class methods .............................................................
  # public instance methods ...................................................

  def amount
    price * quantity
  end

  def diamond_amount
    diamond.present? ? diamond.amount : 0
  end

  # def discounted_amount
  #   amount + promo_total
  # end
  #
  def final_amount
    # amount + adjustment_total
    amount + diamond_amount
  end

  def is_ring?
    is_wedding? || is_engaement?
  end

  def save_engaement_properties(params)
    return unless is_engaement?
    size = Product::Property.find_by(name: 'Size')
    lettering = Product::Property.find_by(name: 'Lettering')
    line_items_properties.find_by(property_id: size.id).update(value: params[:size])
    line_items_properties.find_by(property_id: lettering.id).update(value: params[:lettering])
  end

  def save_wedding_properties(params)
    return unless is_wedding?
    male_size = Product::Property.find_by(name: 'Male Size')
    male_lettering = Product::Property.find_by(name: 'Male Lettering')

    female_size = Product::Property.find_by(name: 'Female Size')
    female_lettering = Product::Property.find_by(name: 'Female Lettering')

    line_items_properties.find_by(property_id: male_size.id).update(value: params[:male_size])
    line_items_properties.find_by(property_id: male_lettering.id).update(value: params[:male_lettering])

    line_items_properties.find_by(property_id: female_size.id).update(value: params[:female_size])
    line_items_properties.find_by(property_id: female_lettering.id).update(value: params[:female_lettering])
  end


  # protected instance methods ................................................
  # private instance methods ..................................................
  private
  def set_prototype
    if product.taxons.pluck(:name).include? "求婚钻戒"
      self.prototype_id = Product::Prototype.find_by(name: "求婚钻戒订单项")
    elsif product.taxons.pluck(:name).include? "结婚对戒"
      self.prototype_id = Product::Prototype.find_by(name: "结婚对戒订单项")
    elsif product.taxons.pluck(:name).include? "钻石"
      self.prototype_id = Product::Prototype.find_by(name: "钻石订单项")
    end
  end

  def add_associations_from_prototype
    if prototype_id && prototype = Product::Prototype.find_by(id: prototype_id)
      prototype.properties.each { |property| line_items_properties.create(property: property) }
      self.option_types = prototype.option_types if respond_to?(:option_types)
    end
  end

  def copy_price
    if variant
      self.price = variant.price if price.nil?
      # self.cost_price = variant.cost_price if cost_price.nil?
      # self.currency = variant.currency if currency.nil?
    end
  end

  def destroy_diamond
    diamond.destroy if diamond
  end

  # def update_related_parent_model_remark
  #   related_parent_model.update_remark_by_line_item(self)
  # end

  # def related_parent_model
  #   order || cart
  # end
end
