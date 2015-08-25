class Frontend::ApplicationController < ApplicationController
  layout ->(controller) { controller.request.xhr? ? false : 'empty' }

  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
