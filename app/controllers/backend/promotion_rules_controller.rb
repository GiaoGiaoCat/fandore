class Backend::PromotionRulesController < Backend::ApplicationController
  skip_before_action :authenticate_user!


  def create
    build_promotion_rule
    save_promotion_rule
  end

  def update
    load_promotion_rule
    build_promotion_rule
    save_promotion_rule
  end

  def destroy
    load_promotion_rule    
    @promotion_rule.destroy
    redirect_to :back
  end

  private

  def load_promotion_rule
    @promotion_rule = Promotion::PromotionRule.find_by(id: params[:promotion_promotion_rule_id])
  end

  def save_promotion_rule
    @promotion_rule.save
    redirect_to :back
  end

  def build_promotion_rule
    @promotion_rule ||= promotion_rule_scope.new
    @promotion_rule.attributes = promotion_rule_params
  end

  def promotion_rule_params
    promotion_rule_params = params[:promotion_promotion_rule]
    promotion_rule_params ? promotion_rule_params.permit(:type_name,
                                   :preferences, :promotion_id) : {}
  end

  def promotion_rule_scope
    Promotion::PromotionRule
  end

end
