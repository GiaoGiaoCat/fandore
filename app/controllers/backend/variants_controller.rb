class Backend::VariantsController < Backend::ApplicationController

  before_action :load_product
  before_action :load_variant, only: [:show, :edit, :update, :destroy]

  def index
    load_variants
  end

  def show
    load_variant
  end

  def new
    build_variant
  end

  def create
    build_variant
    save_variant or render 'new'
  end

  def edit
    load_variant
    build_variant
  end

  def update
    load_variant
    build_variant
    save_variant or render 'edit'
  end

  def destroy
    load_variant
    @variant.destroy
    redirect_to admin_product_variants_path(@product)
  end

  private

  def load_product
    @product ||= product_scope.find(params[:product_id])
  end

  def product_scope
    Product
  end

  def load_variants
    @variants ||= variant_scope.all
  end

  def load_variant
    @variant ||= variant_scope.find(params[:id])
  end

  def build_variant
    @variant ||= variant_scope.new
    @variant.attributes = variant_params
  end

  def save_variant
    if @variant.save
      redirect_to admin_product_variants_path(@product)
    end
  end

  def variant_params
    variant_params = params[:product_variant]
    variant_properties_attributes = [:id, :property_name, :value, :_destroy]
    variant_params ? variant_params.permit(:sku, :price, :position, option_value_ids: [], variant_properties_attributes: variant_properties_attributes) : {}
  end

  def variant_scope
    @product.variants
  end
end
