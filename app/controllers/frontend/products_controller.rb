class Frontend::ProductsController < Frontend::ApplicationController
  skip_before_action :authenticate_user!

  def index
    load_products
  end

  def show
    load_product
    load_diamonds
  end

  private

  def load_diamonds
    @diamonds ||= product_scope.diamonds
  end

  def load_products
    @products ||= product_scope.by_taxon(params[:taxon_name])
  end

  def load_product
    @product ||= product_scope.find(params[:id])
    @variants = @product.variants_including_master.includes([:option_values])
    @product_properties = @product.product_properties.includes(:property)
  end

  def product_scope
    Product
  end
end
