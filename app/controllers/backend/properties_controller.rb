class Backend::PropertiesController < Backend::ApplicationController

  skip_before_action :authenticate_user!
  before_action :load_property, only: [:show, :edit, :update, :destroy]

  def index
    load_properties
  end

  def show
    load_property
  end

  def new
    build_property
  end

  def create
    build_property
    save_property or render 'new'
  end

  def edit
    load_property
    build_property
  end

  def update
    load_property
    build_property
    save_property or render 'edit'
  end

  def destroy
    load_property
    @property.destroy
    redirect_to admin_properties_path
  end

  private

  def load_properties
    @properties ||= property_scope.all
  end

  def load_property
    @property ||= property_scope.find(params[:id])
  end

  def build_property
    @property ||= property_scope.new
    @property.attributes = property_params
  end

  def save_property
    if @property.save
      redirect_to admin_properties_path
    end
  end

  def property_params
    property_params = params[:product_property]
    property_params ? property_params.permit(:name, :presentation) : {}
  end

  def property_scope
    Product::Property
  end
end
