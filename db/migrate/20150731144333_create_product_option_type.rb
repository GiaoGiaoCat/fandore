class CreateProductOptionType < ActiveRecord::Migration
  def change
    create_table :product_option_types do |t|
      t.integer     :position, default: 0, index: true
      t.references  :option_type, index: true
      t.references  :product, index: true

      t.timestamps null: false
    end
  end
end
