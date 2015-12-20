class Frontend::LineItemsController < Frontend::ApplicationController
  skip_before_action :authenticate_user!

  def create
    load_variant
    build_line_item
    save_line_item or render 'new'
  end

  def destroy
    load_line_item
    @line_item.destroy
    redirect_to root_path
  end

  private

  def load_variant
    @variant = Product::Variant.find(params[:variant_id])
  end

  def load_line_item
    @line_item = @cart.line_items.find(params[:id])
  end

  def build_line_item
    @line_item = @cart.add_line_item(@variant)
  end

  def save_line_item
    if @line_item.save
      save_engaement_properties
      save_wedding_properties
      save_diamond_properties
      redirect_to cart_path(@line_item.cart)
    end
  end

  def save_engaement_properties
    return unless @line_item.product.is_engaement
    size = Product::Property.find_by(name: 'Size')
    lettering = Product::Property.find_by(name: 'Lettering')
    @line_item.line_items_properties.find_by(property_id: size.id).update(value: params[:size])
    @line_item.line_items_properties.find_by(property_id: lettering.id).update(value: params[:lettering])
  end

  def save_wedding_properties
    return unless @line_item.product.is_wedding
    male_size = Product::Property.find_by(name: 'Male Size')
    male_lettering = Product::Property.find_by(name: 'Male Lettering')
    
    female_size = Product::Property.find_by(name: 'Female Size')
    female_lettering = Product::Property.find_by(name: 'Female Lettering')

    @line_item.line_items_properties.find_by(property_id: male_size.id).update(value: params[:male_size])
    @line_item.line_items_properties.find_by(property_id: male_lettering.id).update(value: params[:male_lettering])

    @line_item.line_items_properties.find_by(property_id: female_size.id).update(value: params[:female_size])
    @line_item.line_items_properties.find_by(property_id: female_lettering.id).update(value: params[:female_lettering])
  end

  def save_diamond
    if params[:diamond_id]
      diamond = Product::Variant.find(params[:diamond_id])
      line_item = @cart.add_line_item(diamond)
      line_item.type = "Order::Diamond"
      line_item.line_item_id = @line_item.id
      line_item.save
    end
  end
end
