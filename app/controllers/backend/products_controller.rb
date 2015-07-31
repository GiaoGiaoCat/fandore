class Backend::ProductsController < Backend::ApplicationController

  skip_before_action :authenticate_user!
  before_action :load_product, only: [:show, :edit, :update, :destroy]

  def index
    load_products
  end

  def show
    load_product
  end

  def new
    build_product
  end

  def create
    build_product
    save_product or render 'new'
  end

  def edit
    load_product
    build_product
  end

  def update
    load_product
    build_product
    save_product or render 'edit'
  end

  def destroy
    load_product
    @product.destroy
    redirect_to admin_products_path
  end

  private

  def load_products
    @products ||= product_scope.all
  end

  def load_product
    @product ||= product_scope.find(params[:id])
  end

  def build_product
    @product ||= product_scope.new
    @product.attributes = product_params
  end

  def save_product
    if @product.save
      redirect_to admin_products_path
    end
  end

  def product_params
    product_params = params[:product_product]
    product_params ? product_params.permit(:name, :presentation, :category) : {}
  end

  def product_scope
    Product
  end
end
