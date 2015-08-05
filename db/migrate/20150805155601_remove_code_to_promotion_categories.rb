class RemoveCodeToPromotionCategories < ActiveRecord::Migration
  def change
    remove_column :promotion_categories, :code
  end
end
