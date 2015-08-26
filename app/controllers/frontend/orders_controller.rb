class Frontend::OrdersController < Frontend::ApplicationController

  def show
    load_order
  end

  def create
    build_order
    save_order
  end

  private

  def load_order
    @order = order_scope.find(params[:id])
  end

  def build_order
    @order ||= order_scope.new
  end

  def save_order
    @order.add_line_items_from_cart(current_cart)
    if @order.save
      redirect_to order_build_path(:address, :order_id => @order.id)
    end
  end

  def order_scope
    current_user.orders
  end

end
