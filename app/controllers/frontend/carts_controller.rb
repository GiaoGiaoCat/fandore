class Frontend::CartsController < Frontend::ApplicationController

  before_action :load_cart

  def show
  end

  def destroy
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_path
  end

end
