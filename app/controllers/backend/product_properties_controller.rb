class Backend::ProductPropertiesController < Backend::ApplicationController

  before_action :load_product

  def index
  end

  private

  def load_product
    @product ||= product_scope.find(params[:product_id])
  end

  def product_scope
    Product
  end
end
