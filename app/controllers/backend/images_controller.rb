class Backend::ImagesController < Backend::ApplicationController

  before_action :load_product
  before_action :load_image, only: [:show, :edit, :update, :destroy]

  def index
    load_images
  end

  def show
    load_image
  end

  def new
    build_image
  end

  def create
    build_image
    @image.viewable = Product::Variant.find(params[:image][:viewable_id])
    save_image or render 'new'
  end

  def edit
    load_image
  end

  def update
    load_image or render 'edit'
  end

  def destroy
    load_image
    @image.destroy
    redirect_to admin_product_images_path(@product)
  end

  private

  def load_product
    @product ||= product_scope.find(params[:product_id])
  end

  def product_scope
    Product
  end

  def load_image
    @image ||= image_scope.find(params[:id])
  end

  def load_images
    @images ||= image_scope.all
  end

  def build_image
    @image ||= image_scope.new
    @image.attributes = image_params
  end

  def save_image
    if @image.save
      redirect_to admin_product_images_path(@product)
    end
  end

  def image_params
    image_params = params[:image]
    image_params ?  image_params.permit(:picture) : {}
  end

  def image_scope
    @product.variant_images
  end
end
