class Frontend::Users::OrdersController < Frontend::ApplicationController
  
  def index
    load_orders
  end

  def show
    load_order
  end

  private

  def load_orders
    @orders = order_scope
  end

  def load_order
    @order = order_scope.find(params[:id])
  end

  def order_scope
    current_user.orders
  end

end
