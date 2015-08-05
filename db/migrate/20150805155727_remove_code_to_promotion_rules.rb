class RemoveCodeToPromotionRules < ActiveRecord::Migration
  def change
    remove_column :promotion_rules, :code
  end
end
