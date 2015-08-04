class CreateRecommendation < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer     :product_id
      t.integer     :recommend_product_id
      t.integer     :position, index: true

      t.timestamps null: false
    end
  end
end
