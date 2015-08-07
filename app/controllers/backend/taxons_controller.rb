class Backend::TaxonsController < Backend::ApplicationController

  before_action :load_taxonomy, only: [:index, :new, :create]
  before_action :load_taxon, only: [:show, :edit, :update, :destroy]

  def index
    load_taxons
  end

  def show
    load_taxon

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    build_taxon
  end

  def create
    build_taxon
    save_taxon or render 'new'
  end

  def edit
    load_taxon
    build_taxon
  end

  def update
    load_taxon
    build_taxon
    save_taxon or render 'edit'
  end

  def destroy
    load_taxon
    @taxon.destroy unless @taxon.root?
    redirect_to admin_taxons_path
  end

  private

  def load_taxonomy
    @taxonomy ||= taxonomy_scope.find(params[:taxonomy_id])
  end

  def load_taxons
    @taxons ||= @taxonomy.root.children
  end

  def load_taxon
    @taxon ||= taxon_scope.find(params[:id])
  end

  def build_taxon
    @taxon ||= taxon_scope.new(parent: @taxonomy.root)
    @taxon.attributes = taxon_params
  end

  def save_taxon
    if @taxon.save
      redirect_to admin_taxonomy_taxons_path(@taxon.taxonomy)
    end
  end

  def taxon_params
    taxon_params = params[:taxonomy_taxon]
    taxon_params ? taxon_params.permit(:name) : {}
  end

  def taxon_scope
    @taxonomy.present? ? @taxonomy.taxons : Taxonomy::Taxon
  end

  def taxonomy_scope
    Taxonomy
  end
end
