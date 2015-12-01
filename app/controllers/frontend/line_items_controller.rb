class Frontend::LineItemsController < Frontend::ApplicationController

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
      save_properties
      save_diamond
      redirect_to cart_path(@line_item.cart)
    end
  end

  def save_properties
    size = Product::Property.find_by(name: 'Size')
    lettering = Product::Property.find_by(name: 'Lettering')
    @line_item.line_items_properties.find_by(property_id: size.id).update(value: params[:size])
    @line_item.line_items_properties.find_by(property_id: lettering.id).update(value: params[:lettering])
  end

  def save_diamond
    if params[:diamond_id]
      diamond = Product::Variant.find(params[:diamond_id])
      line_item = @cart.add_line_item(diamond)
      line_item.save
    end
  end
end
