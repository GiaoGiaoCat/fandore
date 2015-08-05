class CreatePromotionRules < ActiveRecord::Migration
  def change
    create_table :promotion_rules do |t|
      t.integer :promotion_id
      t.integer :user_id
      t.integer :product_group_id
      t.string :type
      t.text :preferences

      t.timestamps null: false
    end
  end
end
