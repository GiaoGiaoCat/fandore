class Frontend::OrdersController < Frontend::ApplicationController
  def new
    load_line_items
    load_addresses
  end

  private

  def load_line_items
    @line_items = Order::LineItem.where(id: params[:line_items])
  end

  def load_addresses
    @addresses = current_user.addresses
  end


end