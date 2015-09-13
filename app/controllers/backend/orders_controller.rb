class Backend::OrdersController < Backend::ApplicationController

  load_and_authorize_resource :class => "Order"

  def index
    load_orders
  end

  def show
    load_order
  end

  def update
    load_order
    build_order
    save_order
    @order.checkout! if step == :address
    render_wizard @order
  end

  private

  def load_orders
    @orders ||= order_scope.all
  end

  def load_order
    @order = order_scope.find(params[:id])
  end

  def build_order
    @order ||= order_scope.new
    @order.attributes = order_params
  end

  def save_order
    @order.save
  end

  def order_params
    order_params = params[:order]
    # order_params ? order_params.permit(:sku, :price, :position, option_value_ids: [], variant_properties_attributes: variant_properties_attributes) : {}
    order_params ? order_params.permit! : {}
  end

  def order_scope
    Order
  end

end
