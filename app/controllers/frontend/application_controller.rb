class Frontend::ApplicationController < ApplicationController
  layout ->(controller) { controller.request.xhr? ? false : 'empty' }

  private


  def authenticate_user!
    unless current_user && (User::FRONTENDROLE.include? current_user.role)
      redirect_to admin_sign_in_path
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
