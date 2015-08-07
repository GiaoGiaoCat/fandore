class Backend::TaxonomiesController < Backend::ApplicationController

  before_action :load_taxonomy, only: [:show, :edit, :update, :destroy]

  def index
    load_taxonomies
  end

  def show
    load_taxonomy

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    build_taxonomy
  end

  def create
    build_taxonomy
    save_taxonomy or render 'new'
  end

  def edit
    load_taxonomy
    build_taxonomy
  end

  def update
    load_taxonomy
    build_taxonomy
    save_taxonomy or render 'edit'
  end

  def destroy
    load_taxonomy
    @taxonomy.destroy
    redirect_to admin_taxonomies_path
  end

  private

  def load_taxonomies
    @taxonomies ||= taxonomy_scope.all
  end

  def load_taxonomy
    @taxonomy ||= taxonomy_scope.find(params[:id])
  end

  def build_taxonomy
    @taxonomy ||= taxonomy_scope.new
    @taxonomy.attributes = taxonomy_params
  end

  def save_taxonomy
    if @taxonomy.save
      redirect_to admin_taxonomies_path
    end
  end

  def taxonomy_params
    taxonomy_params = params[:taxonomy]
    taxonomy_params ? taxonomy_params.permit(:name) : {}
  end

  def taxonomy_scope
    Taxonomy
  end
end
