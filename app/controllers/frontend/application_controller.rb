class Frontend::ApplicationController < ApplicationController
  layout ->(controller) { controller.request.xhr? ? false : 'empty' }

  private


  def current_cart
    Order::Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Order::Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
