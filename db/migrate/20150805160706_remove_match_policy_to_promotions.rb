class RemoveMatchPolicyToPromotions < ActiveRecord::Migration
  def change
    remove_column :promotions, :match_policy
  end
end
