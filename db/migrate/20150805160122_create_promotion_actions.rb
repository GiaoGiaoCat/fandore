class CreatePromotionActions < ActiveRecord::Migration
  def change
    create_table :promotion_actions do |t|
      t.integer :promotion_id
      t.string :type

      t.timestamps null: false
    end
  end
end
