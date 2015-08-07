class Backend::PromotionsController < Backend::ApplicationController
  skip_before_action :authenticate_user!


  def index
    load_promotions    
  end

  def new
    build_promotion
  end

  def create
    build_promotion
    save_promotion or render "new"
  end

  def edit
    load_promotion    
    build_promotion
    build_rule
    build_action
  end

  def update
    load_promotion    
    build_promotion
    save_promotion or render 'edit'
  end

  def destroy
    load_promotion
    @promotion.destroy
    redirect_to admin_promotion_categories_path
  end

  private

  def load_promotions
    @promotions = promotion_scope.all
  end

  def load_promotion
    @promotion = promotion_scope.find(params[:id])
  end

  def save_promotion
    if @promotion.save
      redirect_to admin_promotions_path
    end
  end


  def build_promotion
    @promotion ||= promotion_scope.new
    @promotion.attributes = promotion_params
  end

  def promotion_params
    promotion_params = params[:promotion]
    promotion_params ? promotion_params.permit(:name, :code, :description, :type, :usage_limit, :starts_at, :expires_at, :promotion_category_id) : {}
  end

  def promotion_scope
    Promotion
  end

  def promotion_save
    if @promotion.save    
      redirect_to admin_promotion_categories_path
    end
  end

  def build_rule
    @rule = (@promotion.rules.blank? ? Promotion::PromotionRule.new : @promotion.rules.last)
  end

  def build_action
    @action = (@promotion.actions.blank? ? Promotion::PromotionAction.new : @promotion.actions.last)
  end

end
