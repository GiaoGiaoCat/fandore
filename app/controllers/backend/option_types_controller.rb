class Backend::OptionTypesController < Backend::ApplicationController

  before_action :load_option_type, only: [:show, :edit, :update, :destroy]

  def index
    load_option_types
  end

  def show
    load_option_type
  end

  def new
    build_option_type
  end

  def create
    build_option_type
    save_option_type or render 'new'
  end

  def edit
    load_option_type
    build_option_type
  end

  def update
    load_option_type
    build_option_type
    save_option_type or render 'edit'
  end

  def destroy
    load_option_type
    @option_type.destroy
    redirect_to admin_option_types_path
  end

  private

  def load_option_types
    @option_types ||= option_type_scope.all
  end

  def load_option_type
    @option_type ||= option_type_scope.find(params[:id])
  end

  def build_option_type
    @option_type ||= option_type_scope.new
    @option_type.attributes = option_type_params
  end

  def save_option_type
    if @option_type.save
      redirect_to admin_option_types_path
    end
  end

  def option_type_params
    option_type_params = params[:product_option_type]
    option_values_attributes = [:id, :name, :presentation, :_destroy]
    option_type_params ? option_type_params.permit(:name, :presentation, :position, option_values_attributes: option_values_attributes) : {}
  end

  def option_type_scope
    Product::OptionType
  end
end
