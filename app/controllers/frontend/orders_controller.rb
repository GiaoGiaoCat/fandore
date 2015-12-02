class Frontend::OrdersController < Frontend::ApplicationController

  def create
    build_order
    save_order
  end

  def update
    load_order
    @order.complete!
    redirect_to order_path(@order)
  end

  private

  def load_orders
    @orders = order_scope
  end

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
