class Frontend::LineItemsController < Frontend::ApplicationController

  before_action :load_cart, :load_variant

  def create
    build_line_item
    save_line_item or render 'new'
  end

  private

  def load_cart
    @cart = current_cart
  end

  def load_variant
    @variant = Product::Variant.find(params[:variant_id])
  end

  def build_line_item
    @line_item = @cart.line_items.build(variant: @variant)
  end

  def save_line_item
    if @line_item.save
      redirect_to @line_item.cart
    end
  end
end
