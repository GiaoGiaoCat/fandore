class Frontend::ApplicationController < ApplicationController
  layout ->(controller) { controller.request.xhr? ? false : 'frontend' }
  before_action :set_gon, :load_cart
  helper_method :current_cart

  private

  def current_cart
    Order::Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Order::Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def load_cart
    @cart = current_cart
  end

  def set_gon
    gon.pageId = view_context.page_id
    gon.controller = controller_name
    gon.action = action_name

    gon.me = {}
  end
end
