class Frontend::CartsController < Frontend::ApplicationController
  skip_before_action :authenticate_user!

  def show
    respond_to do |format|
      format.html { render layout: false }
      format.js
    end
  end

  def destroy
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_path
  end

end
