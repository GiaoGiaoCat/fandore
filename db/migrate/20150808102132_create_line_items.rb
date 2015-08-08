class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :order_id
      t.decimal :price, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal :adjustment_total, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal :additional_tax_total, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal :promo_total, precision: 10, scale: 2, default: 0.0, null: false

      t.timestamps null: false
    end
  end
end
