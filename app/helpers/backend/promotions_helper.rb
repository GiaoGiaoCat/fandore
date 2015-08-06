module Backend::PromotionsHelper
  def rule_form_url
    if @rule.id
      admin_promotion_rule_path
    else
      admin_promotion_rules_path
    end
  end

  def action_form_url
    if @action.id
      admin_promotion_action_path
    else
      admin_promotion_actions_path
    end
  end

end