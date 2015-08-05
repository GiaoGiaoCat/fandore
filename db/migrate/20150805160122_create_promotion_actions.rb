class CreatePromotionActions < ActiveRecord::Migration
  def change
    create_table :promotion_actions do |t|
      t.references :promotion, index: true
      t.string :type
      t.integer :position, default: 0, null: false, index: true

      t.timestamps null: false
    end
  end
end
