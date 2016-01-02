class Frontend::Users::FavoritesController < Frontend::ApplicationController
  def index
    @favorites = current_user.favorites
  end

  def create
    load_product
    @favorite = @product.favorites.create(user: current_user)
  end

  def destroy
    @favorite = current_user.favorites.find_favorites_for_favable('Product', params[:id]).first
    # @favorite = current_user.favorites.find(params[:id])
    @favorite.destroy
  end

  private

  def load_product
    @product ||= product_scope.find(params[:product_id])
  end

  def product_scope
    Product
  end
end
