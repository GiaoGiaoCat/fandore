class Backend::PrototypesController < Backend::ApplicationController

  skip_before_action :authenticate_user!
  before_action :load_prototype, only: [:show, :edit, :update, :destroy]

  def index
    load_prototypes
  end

  def show
    load_prototype
  end

  def new
    build_prototype
  end

  def create
    build_prototype
    save_prototype or render 'new'
  end

  def edit
    load_prototype
    build_prototype
  end

  def update
    load_prototype
    build_prototype
    save_prototype or render 'edit'
  end

  def destroy
    load_prototype
    @prototype.destroy
    redirect_to admin_prototypes_path
  end

  private

  def load_prototypes
    @prototypes ||= prototype_scope.all
  end

  def load_prototype
    @prototype ||= prototype_scope.find(params[:id])
  end

  def build_prototype
    @prototype ||= prototype_scope.new
    @prototype.attributes = prototype_params
  end

  def save_prototype
    if @prototype.save
      redirect_to admin_prototypes_path
    end
  end

  def prototype_params
    prototype_params = params[:product_prototype]
    prototype_params ? prototype_params.permit(:name) : {}
  end

  def prototype_scope
    Product::Prototype
  end
end
