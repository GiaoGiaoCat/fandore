class AddPromotionIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :promotion_id, :integer
  end
end
