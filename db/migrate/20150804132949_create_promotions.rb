class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :description
      t.datetime :expires_at
      t.datetime :starts_at
      t.string :name
      t.string :type_name
      t.integer :usage_limit
      t.integer :promotion_category_id
      t.string :code

      t.timestamps null: false
    end
  end
end
