class CreatePromotionRules < ActiveRecord::Migration
  def change
    create_table :promotion_rules do |t|
      t.references :promotion, index: true
      t.string :type
      t.text :preferences

      t.timestamps null: false
    end
  end
end
