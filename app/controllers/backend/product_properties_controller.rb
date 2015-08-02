class Backend::ProductPropertiesController < Backend::ApplicationController

  skip_before_action :authenticate_user!
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
