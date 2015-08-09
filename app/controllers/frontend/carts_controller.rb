class Frontend::CartsController < Frontend::ApplicationController

  def index
    load_carts
  end

  def create
    load_cart    
    load_variant
    build_quantity
    build_line_item
    @line_item.save
    redirect_to :back
  end

  def destroy
    load_line_item
    @line_item.destroy
    redirect_to :back
  end

  private

  def load_carts
    @carts = current_user.cart.line_items 
  end

  def load_cart
    @cart = Order::Cart.find_or_create_by(user: current_user)
  end

  def load_variant
    @variant = Product::Variant.find(params[:id])
  end

  def load_line_item
    @line_item = Order::LineItem.find(params[:id])
  end

  def build_line_item
    if Order::LineItem.find_by(variant: @variant, cart: @cart)
      @line_item = Order::LineItem.find_by(variant: @variant, cart: @cart)
      @line_item.update(quantity: @line_item.quantity + 1)
      @line_item.save
    else
      @line_item = Order::LineItem.new(variant: @variant, cart: @cart, quantity: 1)
    end
  end

  def build_quantity
    quantity = params[:quantity] != nil ? params[:quantity] : 1
  end

end