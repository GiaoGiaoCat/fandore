class Frontend::ApplicationController < ApplicationController
  layout ->(controller) { controller.request.xhr? ? false : 'frontend' }

  private

  def authenticate_user!
    unless current_user && current_user.frontend_user?
      redirect_to sign_in_path
    end
  end

  def current_cart
    Order::Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Order::Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
