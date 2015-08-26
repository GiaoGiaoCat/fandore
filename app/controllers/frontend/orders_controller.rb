class Frontend::OrdersController < Frontend::ApplicationController

  def show
    load_order
  end

  private

  def load_order
    @order = order_scope.find(params[:id])
  end

  def order_scope
    current_user.orders
  end

end
