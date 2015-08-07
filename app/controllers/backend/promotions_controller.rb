class Backend::PromotionsController < Backend::ApplicationController

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
  end

  def update
    load_promotion
    build_promotion
    save_promotion or render 'edit'
  end

  def destroy
    load_promotion
    @promotion.destroy
    redirect_to admin_promotions_path
  end

  private

  def load_promotions
    @promotions = promotion_scope.all
  end

  def load_promotion
    @promotion = promotion_scope.find(params[:id])
  end

  def build_promotion
    @promotion ||= promotion_scope.new
    @promotion.attributes = promotion_params
  end

  def save_promotion
    if @promotion.save
      redirect_to admin_promotions_path
    end
  end

  def promotion_params
    promotion_params = params[:promotion]
    promotion_params ? promotion_params.permit(:name, :code, :description, :type, :usage_limit, :starts_at, :expires_at, :promotion_category_id) : {}
  end

  def promotion_params
    promotion_params = params[:promotion]
    return Hash.new unless promotion_params

    promotion_actions_attributes = [:id, :type_name, :preferences, :_destroy]
    promotion_rules_attributes = [:id, :type_name, :preferences, :_destroy]
    attrs = [:name, :code, :description, :type, :usage_limit, :starts_at, :expires_at, :promotion_category_id, promotion_actions_attributes: promotion_actions_attributes, promotion_rules_attributes: promotion_rules_attributes]

    params.require(:promotion).permit(attrs)
  end

  def promotion_scope
    Promotion
  end
end
