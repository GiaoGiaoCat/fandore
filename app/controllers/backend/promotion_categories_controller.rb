class Backend::PromotionCategoriesController < Backend::ApplicationController

  def index
    load_promotion_categories
  end

  def new
    build_promotion_category
  end

  def create
    build_promotion_category
    save_promotion_category or render "new"
  end

  def edit
    load_promotion_category
    build_promotion_category
  end

  def update
    load_promotion_category
    build_promotion_category
    save_promotion_category or render 'edit'
  end

  def destroy
    load_promotion_category
    @promotion_category.destroy
    redirect_to admin_promotion_categories_path
  end

  private

  def load_promotion_categories
    @promotion_categories ||= promotion_category_scope.all
  end

  def load_promotion_category
    @promotion_category ||= promotion_category_scope.find(params[:id])
  end

  def build_promotion_category
    @promotion_category ||= promotion_category_scope.new
    @promotion_category.attributes = promotion_category_params
  end

  def save_promotion_category
    if @promotion_category.save
      redirect_to admin_promotion_categories_path
    end
  end

  def promotion_category_params
    promotion_category_params = params[:promotion_promotion_category]
    promotion_category_params ? promotion_category_params.permit(:name, :code) : {}
  end

  def promotion_category_scope
    Promotion::PromotionCategory
  end
end
