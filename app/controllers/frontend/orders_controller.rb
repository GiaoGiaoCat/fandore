class Frontend::OrdersController < Frontend::ApplicationController
  def new
    load_line_items
    load_addresses
    build_order
  end

  def create
    load_line_items
    load_address
    Order.set_order(@line_items, current_user, @address)
  end

  private

  def load_line_items
    @line_items = Order::LineItem.where(id: line_item_params)
  end

  def load_addresses
    @addresses = current_user.addresses
  end

  def load_address
    @address = User::Address.find_by(id: params[:address])
  end

  def build_order
    @order ||= order_scope.new
  end

  def order_scope
    Order    
  end

  def order_params
    address_params = params[:order]
    address_params ? address_params.permit! : {}
  end

  def line_item_params
    if params[:line_items].class == String
      line_item_params = []
      params[:line_items].split(',').each do |line_item|
        line_item_params << line_item.to_i
      end
    else
      line_item_params = params[:line_items]
    end
  end

end