class Backend::PromotionActionsController < Backend::ApplicationController
  skip_before_action :authenticate_user!


  def create
    build_promotion_action
    save_promotion_action
  end

  def update
    load_promotion_action
    build_promotion_action
    save_promotion_action
  end

  def destroy
    load_promotion_action
    @promotion_action.destroy
    redirect_to :back
  end

  private
  def load_user
    @user = current_user
  end

  def load_promotion_action
    @promotion_action = Promotion::PromotionAction.find(params[:promotion_promotion_action_id])
  end

  def save_promotion_action
    @promotion_action.save
    redirect_to :back
  end

  def build_promotion_action
    @promotion_action ||= promotion_action_scope.new
    @promotion_action.attributes = promotion_action_params
  end

  def promotion_action_params
    promotion_action_params = params[:promotion_promotion_action]
    promotion_action_params ? promotion_action_params.permit(:type_name,
                                   :preferences, :promotion_id) : {}
  end

  def promotion_action_scope
    Promotion::PromotionAction
  end

  def promotion_action_save
    @promotion_action.save    
    redirect_to :back
  end

end
