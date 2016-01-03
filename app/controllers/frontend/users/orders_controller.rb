class Frontend::Users::OrdersController < Frontend::ApplicationController

  def index
    load_orders
  end

  def show
    load_order
  end

  def update_state
    load_order
    @order.update_state_with_track!(params[:event], current_user)
  end

  private

  def load_orders
    @orders = order_scope
  end

  def load_order
    @order = order_scope.find_by_encrypted_id(params[:id])
  end

  def order_scope
    current_user.orders
  end

end
