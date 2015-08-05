class Frontend::Users::FavoritesController < Frontend::ApplicationController
  def create
    load_product
    @product.favorites.create(user: current_user)
  end

  def destroy

  end

  private

  def load_product
    @product ||= product_scope.find(params[:product_id])
  end

  def product_scope
    Product
  end
end
